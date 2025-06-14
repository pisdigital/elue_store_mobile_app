import 'package:elue_store/common/widgets/appbar/tabbar.dart';
import 'package:elue_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:elue_store/features/shop/controllers/categories_controller.dart';
import 'package:elue_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:elue_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:elue_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../home_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/product/favourites_controller.dart';
import '../store/store.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.allCategories;
    return PopScope(
      canPop: false,
      // Intercept the back button press and redirect to Home Screen
      onPopInvoked: (value) async => Get.offAll(const HomeMenu()),
      child: DefaultTabController(
        length: categories.length,
        child: Scaffold(

            /// -- Appbar -- Tutorial [Section # 3, Video # 7]
            appBar: TAppBar(
              title: Text('Categories',
                  style: Theme.of(context).textTheme.headlineMedium),
              actions: const [TCartCounterIcon()],
            ),
            body: Column(
              children: [
                const TPromoSlider(),
                Expanded(
                  child: NestedScrollView(
                    /// -- Header -- Tutorial [Section # 3, Video # 7]
                    headerSliverBuilder: (_, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          pinned: true,
                          floating: true,
                          // Space between Appbar and TabBar. WithIn this height we have added [Search bar] and [Featured brands]
                          expandedHeight: 10,
                          automaticallyImplyLeading: false,
                          backgroundColor: TColors.white,

                          /// -- TABS
                          bottom: TTabBar(
                              tabs: categories
                                  .map((e) => Tab(child: Text(e.name)))
                                  .toList()),
                        )
                      ];
                    },

                    /// -- TabBar Views
                    body: TabBarView(
                      children: categories
                          .map((category) => TCategoryTab(category: category))
                          .toList(),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
    // PopScope(
    //   canPop: false,
    //   // Intercept the back button press and redirect to Home Screen
    //   onPopInvoked: (value) async => Get.offAll(const HomeMenu()),
    //   child: Scaffold(
    //     appBar: TAppBar(
    //       title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
    //       actions: [TCircularIcon(icon: Iconsax.add, onPressed: () => Get.to(() => const StoreScreen()))],
    //     ),
    //     body: SingleChildScrollView(
    //       child: Padding(
    //         padding: const EdgeInsets.all(TSizes.defaultSpace),
    //         child: Column(
    //           children: [

    //             /// Products Grid
    //             Obx(() {
    //               return FutureBuilder(
    //                 future: FavouritesController.instance.favoriteProducts(),
    //                 builder: (_, snapshot) {
    //                   /// Nothing Found Widget
    //                   final emptyWidget = TAnimationLoaderWidget(
    //                     text: 'Wishlist is Empty...',
    //                     animation: TImages.emptyAnimation,
    //                     showAction: true,
    //                     actionText: 'Let\'s add some',
    //                     onActionPressed: () => Get.off(() => const HomeMenu()),
    //                   );
    //                   const loader = TVerticalProductShimmer(itemCount: 6);
    //                   final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
    //                   if (widget != null) return widget;

    //                   final products = snapshot.data!;
    //                   return TGridLayout(
    //                     itemCount: products.length,
    //                     itemBuilder: (_, index) => TProductCardVertical(product: products[index]),
    //                   );
    //                 },
    //               );
    //             }),
    //             SizedBox(height: TDeviceUtils.getBottomNavigationBarHeight() + TSizes.defaultSpace),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
