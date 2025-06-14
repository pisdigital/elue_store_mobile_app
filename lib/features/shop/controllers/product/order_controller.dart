import 'package:elue_store/common/widgets/success_screen/success_screen.dart';
import 'package:elue_store/data/repositories/user/user_repository.dart';
import 'package:elue_store/data/services/paypal/paypal.dart';
import 'package:elue_store/features/authentication/screens/login/login.dart';
import 'package:elue_store/features/authentication/screens/signup/verify_email.dart';
import 'package:elue_store/features/personalization/controllers/user_controller.dart';
import 'package:elue_store/features/shop/models/cart_item_model.dart';
import 'package:elue_store/features/shop/models/order_request.dart';
import 'package:elue_store/utils/helpers/helper_functions.dart';
import 'package:elue_store/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../home_menu.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../models/order_model.dart';
import 'cart_controller.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController {
  final logger = Logger();
  static OrderController get instance => Get.find();
  late final Rx<User?> _firebaseUser;
  final _auth = FirebaseAuth.instance;
  final deviceStorage = GetStorage();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = Get.find<CheckoutController>();
  final orderRepository = Get.put(OrderRepository());
  final userController = Get.put(UserController());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      if (!userController.isUserLoggedIn()) {
        return [];
      }
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  screenRedirect(User? user) async {
    if (user != null) {
      Get.offAll(() => const LoginScreen());
      // User Logged-In: If email verified let the user proceed else to the Email Verification Screen
      if (user.emailVerified) {
        // Initialize User Specific Storage
        await TLocalStorage.init(user.uid);
        return;
      } else {
        Get.offAll(
            () => VerifyEmailScreen(email: _firebaseUser.value?.email ?? ""));
      }
    } else {
      return;
    }
  }

  /// Add methods for order processing
  void processOrder(BuildContext context, double subTotal,
      List<CartItemModel> cartItems) async {
    try {
      UserController userController = Get.put(UserController());
      if (!userController.isUserLoggedIn()) {
        return showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: SizedBox(
              height: MediaQuery.of(_).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Login To Checkout',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Text('Please login Finish checkout'),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.offAll(() => const LoginScreen()),
                        child: const Text('Login'),
                      ))
                ],
              ),
            ),
          ),
        );
      }
      if (addressController.selectedAddress.value.id.isEmpty) {
        return showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: SizedBox(
              height: MediaQuery.of(_).size.height * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Add address to continue',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Text(
                      'Please select your address information to continue.'),
                ],
              ),
            ),
          ),
        );
      }
      TFullScreenLoader.openLoadingDialog(
          "Placing Order", TImages.pencilAnimation);
      // Start Loader
      // TFullScreenLoader.openLoadingDialog(
      //     'Processing your order', TImages.pencilAnimation);
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.to(const LoginScreen());
      }
      //TODO: CREATE USER PROFILE IN LOCAL BACKEND AND ASSIGN ORDER TO IT
      if (user != null) {
        final userRepository = Get.find<UserRepository>();
        await userRepository.createUserProfile(user);
      }
      // _firebaseUser = Rx<User?>(_auth.currentUser);
      // _firebaseUser.bindStream(_auth.userChanges());
      // screenRedirect(_firebaseUser.value);
      // Get user authentication Id
      final userId = AuthenticationRepository.instance.getUserID;
      if (userId.isEmpty) {}

      if (addressController.billingSameAsShipping.isFalse) {
        if (addressController.selectedBillingAddress.value.id.isEmpty) {
          TLoaders.warningSnackBar(
              title: 'Billing Address Required',
              message: 'Please add Billing Address in order to proceed.');
          return;
        }
      }
      //TODO: create cart item for each item & create cart with the cart_item ids then create order by adding cart id to order

      List<int> cartItemIds = [];

      for (var item in cartController.cartItems) {
        int id = await orderRepository.createCartItem(item);
        cartItemIds.add(id);
      }

      int cartId = await orderRepository.createCart(cartItemIds);
      // Add Details
      final order = OrderRequest(
        // Generate a unique ID for the order
        userId: userId,
        orderStatus: "PENDING",
        totalAmount: checkoutController.getTotal(subTotal),
        shippingAddress: addressController.selectedAddress.value.toString(),
        billingAddress:
            addressController.selectedBillingAddress.value.toString(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.id ?? 0,
        billingAddressSameAsShipping:
            addressController.billingSameAsShipping.value,
        items: cartId,
        shippingCost: checkoutController.getShippingCost(subTotal),
        taxCost: checkoutController.getTaxAmount(subTotal),
      );

      // Trigger payment gateway
      if (checkoutController.selectedPaymentMethod.value.name.toLowerCase() ==
          PaymentMethods.paypal.name) {
        TFullScreenLoader.stopLoading();
        final response = await TPaypalService.getPayment(
            subTotal, cartItems, addressController.selectedAddress.value);
        logger.i('Paypal Payment is ${response ? 'Successful' : 'Failed'}');
        logger.i("onResponse: $response");
        if (response) {
          TLoaders.successSnackBar(
              title: 'Congratulations', message: 'Paypal Payment Paid');
          // Save the order on backend
          await orderRepository.saveOrder(
              order, userId, checkoutController.receiptFile.value);
          cartController.clearCart();
          Get.off(() => SuccessScreen(
                image: TImages.orderCompletedAnimation,
                title: 'Payment Success!',
                subTitle: 'We are reviewing your order!',
                onPressed: () => Get.offAll(() => const HomeMenu()),
              ));
        }
        if (!response) {
          TLoaders.warningSnackBar(
              title: 'Failed', message: 'Paypal Payment Failed');
        }
      } else {
        cartController.clearCart();
        // Save the order on backend
        await orderRepository.saveOrder(
            order, userId, checkoutController.receiptFile.value);
        TFullScreenLoader.stopLoading();
        Get.off(() => SuccessScreen(
              image: TImages.orderCompletedAnimation,
              title: 'Order Success!',
              subTitle: 'We are reviewing your order!',
              onPressed: () => Get.offAll(() => const HomeMenu()),
            ));
      }

      checkoutController.clearController();
      // Once the order placed, update Stock of each item
      // final productController = Get.put(ProductController());

      // for (var product in cartController.cartItems) {
      //   await productController.updateProductStock(
      //       product.productId, product.quantity, product.variationId);
      // }

      // Update the cart status
      // cartController.clearCart();

      // Show Success screen
      // Get.off(() => SuccessScreen(
      //       image: TImages.orderCompletedAnimation,
      //       title: 'Payment Success!',
      //       subTitle: 'Your item will be delivered soon!',
      //       onPressed: () => Get.offAll(() => const HomeMenu()),
      //     ));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
