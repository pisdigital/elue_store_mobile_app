import 'package:elue_store/features/authentication/controllers/store_selection_controller.dart';
import 'package:elue_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:elue_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:elue_store/utils/constants/enums.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/products/cart/billing_amount_section.dart';
import '../../../../common/widgets/products/cart/coupon_code.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/order_controller.dart';
import '../cart/widgets/cart_items.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_payment_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController = CheckoutController.instance;
    final cartController = CartController.instance;
    final addressController = AddressController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const TAppBar(title: Text('Order Review'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TPromoSlider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Items in Cart
              const TCartItems(showAddRemoveButtons: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// -- Coupon TextField
              // const TCouponCode(),
              // const SizedBox(height: TSizes.spaceBtwSections),

              /// -- Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    TBillingAmountSection(subTotal: subTotal),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Payment Methods
                    const TBillingPaymentSection(),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// Address
                    const TAddressSection(isBillingAddress: false),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Obx(() {
                      final paymentMethod = checkoutController
                          .selectedPaymentMethod
                          .toString()
                          .toLowerCase();
                      if (paymentMethod != 'paypal') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            Text(
                              'Upload Payment Receipt',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            GestureDetector(
                              onTap: () => checkoutController.uploadReceipt(),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(TSizes.md),
                                decoration: BoxDecoration(
                                  border: Border.all(color: TColors.grey),
                                  borderRadius: BorderRadius.circular(
                                      TSizes.cardRadiusLg),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.upload_file,
                                        color: TColors.primary),
                                    const SizedBox(width: TSizes.sm),
                                    Expanded(
                                      child: Obx(() => Text(
                                            checkoutController.receiptFileName
                                                    .value.isEmpty
                                                ? 'Upload bank slip/receipt'
                                                : checkoutController
                                                    .receiptFileName.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    }),

                    /// Divider
                    // const Divider(),
                    // const SizedBox(height: TSizes.spaceBtwItems),

                    /// Address Checkbox
                    // Obx(
                    //   () => CheckboxListTile(
                    //     controlAffinity: ListTileControlAffinity.leading,
                    //     title: const Text(
                    //         'Billing Address is Same as Shipping Address'),
                    //     value: addressController.billingSameAsShipping.value,
                    //     onChanged: (value) => addressController
                    //         .billingSameAsShipping.value = value ?? true,
                    //   ),
                    // ),
                    // const SizedBox(height: TSizes.spaceBtwItems),

                    // /// Divider
                    // Obx(() => !addressController.billingSameAsShipping.value
                    //     ? const Divider()
                    //     : const SizedBox.shrink()),

                    // /// Shipping Address
                    // Obx(() => !addressController.billingSameAsShipping.value
                    //     ? const TAddressSection(isBillingAddress: true)
                    //     : const SizedBox.shrink()),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),

      /// -- Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: subTotal > 0
                ? () {
                    final paymentMethod = checkoutController
                        .selectedPaymentMethod.value.name
                        .split(' ')
                        .join('')
                        .toLowerCase();
                    print('Payment Method: $paymentMethod');
                    if ((paymentMethod == PaymentMethods.paypal.name ||
                        paymentMethod == PaymentMethods.cashondelivery.name)) {
                      print('Payment Method: $paymentMethod');
                    } else {
                      if (checkoutController.receiptFileName.value.isEmpty) {
                        print(
                            'Receipt not attached?: ${checkoutController.receiptFileName.value.isEmpty}');
                        // if (checkoutController.receiptFileName.value.isEmpty) {
                        TLoaders.warningSnackBar(
                          title: 'Receipt Required',
                          message: 'Please upload payment receipt to continue.',
                        );
                        return;
                      }
                    }
                    orderController.processOrder(
                        context, subTotal, cartController.cartItems);
                  }
                : () => TLoaders.warningSnackBar(
                    title: 'Empty Cart',
                    message: 'Add items in the cart in order to proceed.'),
            child: Text(
                'Checkout ${StoreSelectionController.instance.getCurrency()} ${checkoutController.getTotal(subTotal).toStringAsFixed(2)}'),
          ),
        ),
      ),
    );
  }
}
