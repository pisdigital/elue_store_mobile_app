import 'package:elue_store/data/repositories/product/product_repository.dart';
import 'package:elue_store/features/shop/controllers/categories_controller.dart';
import 'package:elue_store/features/shop/screens/all_products/all_products.dart';
import 'package:elue_store/home_menu.dart';
import 'package:elue_store/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../common/widgets/shimmers/brands_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/brand_controller.dart';
import '../brand/all_brands.dart';
import '../brand/brand.dart';
import '../home/widgets/header_search_container.dart';
import 'widgets/category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AllProducts(
      title: TTexts.newProducts,
      bigTitle: true,
      showBackButton: false,
      futureMethod: ProductRepository.instance.getFeaturedProducts(),
    );
    // PopScope(
    //   canPop: false,
    //     // Intercept the back button press and redirect to Home Screen
    //   onPopInvoked: (value) async => Get.offAll(const HomeMenu()),
    //   child: DefaultTabController(
    //     length: categories.length,
    //     child: Scaffold(
    //       /// -- Appbar -- Tutorial [Section # 3, Video # 7]
    //       appBar: TAppBar(
    //         title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
    //         actions: const [TCartCounterIcon()],
    //       ),
    //       body: NestedScrollView(
    //         /// -- Header -- Tutorial [Section # 3, Video # 7]
    //         headerSliverBuilder: (_, innerBoxIsScrolled) {
    //           return [
    //             SliverAppBar(
    //               pinned: true,
    //               floating: true,
    //               // Space between Appbar and TabBar. WithIn this height we have added [Search bar] and [Featured brands]
    //               // expandedHeight: 440,
    //               automaticallyImplyLeading: false,
    //               backgroundColor: dark ? TColors.black : TColors.white,
    //               /// -- TABS
    //               bottom: TTabBar(tabs: categories.map((e) => Tab(child: Text(e.name))).toList()),
    //             )
    //           ];
    //         },

    //         /// -- TabBar Views
    //         body: TabBarView(
    //           children: categories.map((category) => TCategoryTab(category: category)).toList(),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
