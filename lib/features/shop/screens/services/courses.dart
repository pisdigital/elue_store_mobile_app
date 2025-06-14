import 'package:country_flags/country_flags.dart';
import 'package:elue_store/common/widgets/appbar/appbar.dart';
import 'package:elue_store/features/shop/screens/services/contact_info.dart';
import 'package:elue_store/utils/constants/image_strings.dart';
import 'package:elue_store/utils/constants/sizes.dart';
import 'package:elue_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Courses extends StatelessWidget {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Courses',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50.0),
                  padding: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 15,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      const Text(
                        "Drop Shipping Courses",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Image(
                        width: THelperFunctions.screenWidth() * 0.8,
                        height: THelperFunctions.screenHeight() * 0.2,
                        image: const AssetImage(TImages.dropshipping),
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(const ContactInfo());
                          },
                          child: const Text("Contact Us"))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50.0),
                  padding: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 15,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      const Text(
                        "Coding Courses",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Image(
                        width: THelperFunctions.screenWidth() * 0.8,
                        height: THelperFunctions.screenHeight() * 0.2,
                        image: const AssetImage(TImages.coding),
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(const ContactInfo());
                          },
                          child: const Text("Contact Us"))
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                Image(
                  width: THelperFunctions.screenWidth() * 0.4,
                  height: THelperFunctions.screenHeight() * 0.2,
                  image: const AssetImage(TImages.lightAppLogo),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                const Text(
                  "All Rights Reserved © Eluestore 2024",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
