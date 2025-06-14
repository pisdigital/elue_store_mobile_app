import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/banner_controller.dart';

/// Widget to display a promo slider using GetX state management.
class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key, this.showPosition, this.height});
  final bool? showPosition;
  final double? height;
  @override
  Widget build(BuildContext context) {
    // Get instance of BannerController using GetX
    final controller = Get.put(BannerController());

    // Use Obx widget to automatically rebuild the UI when banners state changes
    return Obx(
      () {
        // Loader
        if (controller.bannersLoading.value)
          return const TShimmerEffect(width: double.infinity, height: 80);

        // No data found
        if (controller.banners.isEmpty) {
          return Container();
        } else {
          /// Record Found! 🎊
          // Display CarouselSlider with banners and page indicator
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: height ?? 80,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index),
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  enlargeCenterPage: true,
                ),
                items: controller.banners
                    .map(
                      (banner) => Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: TSizes.defaultSpace),
                        child: TRoundedImage(
                          imageUrl: banner.imageUrl,
                          fit: BoxFit.cover,
                          isNetworkImage: true,
                          onPressed: () => {},
                          // onPressed: () => Get.toNamed(banner.targetScreen),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              (showPosition == null && showPosition != false)
                  ? Center(
                      child: Obx(
                        () => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Display page indicators based on the number of banners
                            for (int i = 0; i < controller.banners.length; i++)
                              TCircularContainer(
                                width: 20,
                                height: 4,
                                margin: const EdgeInsets.only(right: 10),
                                backgroundColor:
                                    controller.carousalCurrentIndex.value == i
                                        ? TColors.primary
                                        : TColors.grey,
                              ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          );
        }
      },
    );
  }
}
