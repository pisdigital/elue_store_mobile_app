import 'package:elue_store/features/authentication/screens/login/login.dart';
import 'package:elue_store/features/shop/screens/home/widgets/promo_slider.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../home_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/screens/cart/cart.dart';
import '../../../shop/screens/order/order.dart';
import '../../controllers/user_controller.dart';
import '../address/address.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return PopScope(
      canPop: false,
      // Intercept the back button press and redirect to Home Screen
      onPopInvoked: (value) async => Get.offAll(const HomeMenu()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// -- Header
              TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    /// AppBar
                    TAppBar(
                      title: Text(
                        'Account',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium!.apply(color: TColors.black),
                      ),
                    ),

                    /// User Profile Card
                    TUserProfileTile(onPressed: () => Get.to(() {})),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),

              /// -- Profile Body
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TPromoSlider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// -- Account  Settings
                    const TSectionHeading(
                      title: 'Account Settings',
                      showActionButton: false,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TSettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'My Cart',
                      subTitle: 'Add, remove products and move to checkout',
                      onTap: () => Get.to(() => const CartScreen()),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Orders',
                      subTitle: 'In-progress and Completed Orders',
                      onTap: () => Get.to(() => const OrderScreen()),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    

                    /// -- Logout Button
                    const SizedBox(height: TSizes.spaceBtwSections),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => controller.isUserLoggedIn()
                            ? controller.logout()
                            : Get.offAll(const LoginScreen()),
                        child: controller.isUserLoggedIn()
                            ? const Text('Logout')
                            : const Text("Login"),
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwSections * 2.5),

                    Center(
  child: InkWell(
    onTap: () => controller.deleteUserAccount(),
    child: Text(
      'Delete Account',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.red, // This sets the text color to red
      ),
    ),
  ),
),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}