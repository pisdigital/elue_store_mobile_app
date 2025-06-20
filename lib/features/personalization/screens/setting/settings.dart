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
                    // TSettingsMenuTile(
                    //   icon: Iconsax.safe_home,
                    //   title: 'My Addresses',
                    //   subTitle: 'Set shopping delivery address',
                    //   onTap: () => Get.to(() => const UserAddressScreen()),
                    // ),
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
                    // const TSettingsMenuTile(
                    //     icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account'),
                    // const TSettingsMenuTile(
                    //     icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'List of all the discounted coupons'),
                    // TSettingsMenuTile(
                    //     icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set any kind of notification message', onTap: () {}),
                    // const TSettingsMenuTile(
                    //     icon: Iconsax.security_card, title: 'Account Privacy', subTitle: 'Manage data usage and connected accounts'),

                    /// -- App Settings
                    // const SizedBox(height: TSizes.spaceBtwSections),
                    // const TSectionHeading(title: 'App Settings', showActionButton: false),
                    // const SizedBox(height: TSizes.spaceBtwItems),
                    // TSettingsMenuTile(
                    //   icon: Iconsax.document_upload,
                    //   title: 'Load Data',
                    //   subTitle: 'Upload Data to your Cloud Firebase',
                    //   onTap: () => Get.to(() => const UploadDataScreen()),
                    // ),
                    // const SizedBox(height: TSizes.spaceBtwItems),
                    // TSettingsMenuTile(
                    //   icon: Iconsax.location,
                    //   title: 'Geolocation',
                    //   subTitle: 'Set recommendation based on location',
                    //   trailing: Switch(value: true, onChanged: (value) {}),
                    // ),
                    // TSettingsMenuTile(
                    //   icon: Iconsax.security_user,
                    //   title: 'Safe Mode',
                    //   subTitle: 'Search result is safe for all ages',
                    //   trailing: Switch(value: false, onChanged: (value) {}),
                    // ),
                    // TSettingsMenuTile(
                    //   icon: Iconsax.image,
                    //   title: 'HD Image Quality',
                    //   subTitle: 'Set image quality to be seen',
                    //   trailing: Switch(value: false, onChanged: (value) {}),
                    // ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    const Center(
                      child: 
                      InkWell( () {
                            controller.deleteUserAccount(); 
                                    },
                       child: Text('Delete Account', style: Theme.of(context).textTheme.bodySmall))))

                    /// -- Logout Button
                    const SizedBox(height: TSizes.spaceBtwSections),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed:
                            () =>
                                controller.isUserLoggedIn()
                                    ? controller.logout()
                                    : Get.offAll(const LoginScreen()),
                        child:
                            controller.isUserLoggedIn()
                                ? const Text('Logout')
                                : const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections * 2.5),
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
