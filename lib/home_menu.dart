import 'package:elue_store/utils/constants/colors.dart';
import 'package:elue_store/utils/constants/image_strings.dart';
import 'package:elue_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/personalization/screens/setting/settings.dart';
import 'features/shop/screens/favourites/favourite.dart';
import 'features/shop/screens/home/home.dart';
import 'features/shop/screens/store/store.dart';

class HomeMenu extends StatelessWidget {
  final int initialIndex;
  const HomeMenu({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppScreenController(initialIndex: initialIndex));
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          animationDuration: const Duration(seconds: 3),
          selectedIndex: controller.selectedMenu.value,
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.black
              : Colors.white,
          elevation: 0,
          indicatorColor: THelperFunctions.isDarkMode(context)
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          onDestinationSelected: (index) =>
              controller.selectedMenu.value = index,
          destinations: const [
            NavigationDestination(
                icon: ImageIcon(
                  AssetImage(TImages.home),
                  color: Colors.black,
                ),
                label: 'Home'),
            NavigationDestination(
                icon: ImageIcon(
                  AssetImage(TImages.store),
                  color: Colors.black,
                ),
                label: 'New'),
            NavigationDestination(
                icon: ImageIcon(
                  AssetImage(TImages.wishlist),
                  color: Colors.black,
                ),
                label: 'Categories'),
            NavigationDestination(
                icon: ImageIcon(
                  AssetImage(TImages.profile),
                  color: Colors.black,
                ),
                label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedMenu.value]),
    );
  }
}

class AppScreenController extends GetxController {
  static AppScreenController get instance => Get.find();

  final int initialIndex;
  AppScreenController({this.initialIndex = 0});

  final Rx<int> selectedMenu = 0.obs;

  @override
  void onInit() {
    selectedMenu.value = initialIndex;
    super.onInit();
  }

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const FavouriteScreen(),
    const SettingsScreen()
  ];
}
