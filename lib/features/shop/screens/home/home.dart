import 'package:elue_store/common/widgets/custom_shapes/containers/secondary_header_container.dart';
import 'package:elue_store/features/shop/controllers/home_controller.dart';
import 'package:elue_store/features/shop/controllers/product/product_controller.dart';
import 'package:elue_store/features/shop/screens/home/widgets/header_detail_container.dart';
import 'package:elue_store/features/shop/screens/home/widgets/information_services_widget.dart';
import 'package:elue_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:elue_store/features/shop/screens/services/contact_info.dart';
import 'package:elue_store/features/shop/screens/services/courses.dart';
import 'package:elue_store/features/shop/screens/services/design.dart';
import 'package:elue_store/features/shop/screens/services/flight_booking.dart';
import 'package:elue_store/features/shop/screens/services/printing.dart';
import 'package:elue_store/features/shop/screens/services/socials.dart';
import 'package:elue_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../all_products/all_products.dart';
import 'widgets/header_categories.dart';
import 'widgets/header_search_container.dart';
import 'widgets/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve existing instances of controllers
    final controller = Get.put(ProductController());
    final homeController = Get.put(HomeController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (homeController.activeTabIndex == 1) {
                /// Header
                return SecondaryHeaderContainer(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// -- Appbar
                    const THomeAppBar(),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    const HeaderDetailContainer(),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TabChanger(
                            controller: homeController,
                            index: 0,
                            title: "Products"),
                        const SizedBox(width: 15),
                        TabChanger(
                            controller: homeController,
                            index: 1,
                            title: "Services"),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ));
              }

              return

                  /// Header
                  TPrimaryHeaderContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// -- Appbar
                    const THomeAppBar(),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    const HeaderDetailContainer(),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TabChanger(
                            controller: homeController,
                            index: 0,
                            title: "Products"),
                        const SizedBox(width: 15),
                        TabChanger(
                            controller: homeController,
                            index: 1,
                            title: "Services"),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// -- Searchbar
                    const TSearchContainer(text: 'Search', showBorder: true),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// -- Categories
                    const THeaderCategories(),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              );
            }),

            /// -- Body
            Obx(
              () {
                if (homeController.activeTabIndex == 1) {
                  return InformationServicesWidget();
                }

                // Default content for other activeTabIndex values
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const TPromoSlider(),

                      /// -- Products Heading
                      TSectionHeading(
                        title: TTexts.popularProducts,
                        onPressed: () => Get.to(
                          () => AllProducts(
                            title: TTexts.popularProducts,
                            showBackButton: true,
                            futureMethod: ProductRepository.instance
                                .getFeaturedProducts(),
                          ),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// Products Section
                      Obx(
                        () {
                          // Display loader while products are loading
                          if (controller.isLoading.value) {
                            return const TVerticalProductShimmer();
                          }

                          // Check if no featured products are found
                          if (controller.featuredProducts.isEmpty) {
                            return Center(
                              child: Text(
                                'No Data Found!',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          } else {
                            // Featured Products Found! 🎊
                            return TGridLayout(
                              itemCount: controller.featuredProducts.length,
                              itemBuilder: (_, index) => TProductCardVertical(
                                product: controller.featuredProducts[index],
                                isNetworkImage: true,
                              ),
                            );
                          }
                        },
                      ),

                      SizedBox(
                        height: TDeviceUtils.getBottomNavigationBarHeight() +
                            TSizes.defaultSpace,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
