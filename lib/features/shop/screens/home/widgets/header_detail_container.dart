import 'package:elue_store/features/shop/controllers/home_controller.dart';
import 'package:elue_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class HeaderDetailContainer extends StatelessWidget {
  const HeaderDetailContainer({
    super.key,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final homeController =
        Get.put(HomeController()); // Initialize the controller

    return Padding(
      padding: padding,
      child: Container(
        width: TDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.symmetric(
            horizontal: TSizes.md, vertical: TSizes.md),
        height: 170,
        decoration: BoxDecoration(
          color: const Color(0XFF024B59),
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          // border: Border.all(color: TColors.grey),
        ),
        child: const Column(
          children: [
            Text(
              "Welcome to ElueStore!",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Your premier online shopping destination",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 20),
            TPromoSlider(
              showPosition: false,
              height: 60,
            ),
            // SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class TabChanger extends StatelessWidget {
  const TabChanger({
    super.key,
    required this.controller,
    required this.index,
    required this.title,
  });

  final HomeController controller;
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          controller.activeTabIndex.value = index; // Update tab index
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
          decoration: BoxDecoration(
            color: controller.activeTabIndex.value == index
                ? const Color(0XFFA4C74D) // Active tab color
                : Colors.transparent, // Inactive tab color
            borderRadius: BorderRadius.circular(16),
            border: controller.activeTabIndex.value == index
                ? Border.all(color: TColors.grey)
                : Border.all(color: const Color(0XFF024B59)),
          ),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 12,
                color: controller.activeTabIndex.value == index
                    ? Colors.white
                    : const Color(0XFF024B59),
                fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    });
  }
}
