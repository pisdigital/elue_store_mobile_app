import 'package:elue_store/common/widgets/shimmers/shimmer.dart';
import 'package:elue_store/features/authentication/screens/store_selection/widgets/store_selection_dropdown.dart';
import 'package:elue_store/features/personalization/controllers/settings_controller.dart';
import 'package:elue_store/features/shop/controllers/product/cart_controller.dart';
import 'package:elue_store/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../../personalization/screens/profile/profile.dart';
import 'package:country_flags/country_flags.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Just to create instance and fetch values
    Get.put(SettingsController());
    final userController = Get.put(UserController());
    return TAppBar(
      title: GestureDetector(
        onTap: () {},
        // onTap: () => Get.to(() => const ProfileScreen()),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              width: 100,
              height: 100,
              image: AssetImage(TImages.headerLogo),
            ),
          ],
        ),
      ),
      actions: const [
        TCartCounterIcon(
            iconColor: TColors.white,
            counterBgColor: TColors.black,
            counterTextColor: TColors.white),
        SizedBox(
          width: 10.0,
        ),
        VerticalDivider(
          color: TColors.white,
          thickness: 1,
          indent: 15,
          endIndent: 15,
        ),
        SizedBox(
          width: 10.0,
        ),
        StoreSelectionDropdown()
      ],
    );
  }
}
