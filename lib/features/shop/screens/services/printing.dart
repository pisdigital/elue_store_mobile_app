import 'package:country_flags/country_flags.dart';
import 'package:elue_store/common/widgets/appbar/appbar.dart';
import 'package:elue_store/features/shop/screens/services/contact_info.dart';
import 'package:elue_store/utils/constants/image_strings.dart';
import 'package:elue_store/utils/constants/sizes.dart';
import 'package:elue_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Printing extends StatelessWidget {
  const Printing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Printing Services',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image(
                  width: THelperFunctions.screenWidth() * 0.8,
                  height: THelperFunctions.screenHeight() * 0.2,
                  image: const AssetImage(TImages.dropshipping),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
                          borderRadius: BorderRadius.circular(20.0)),
                      child: const Column(
                        children: [
                          Text(
                            "Business Cards",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            "Invitations",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            "Posters",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            "T-Shirts",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            "hoodies",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Container(
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
                          borderRadius: BorderRadius.circular(20.0)),
                      child: const Column(
                        children: [
                          Text(
                            "Sweatshirts",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            "Mugs",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            "Water Bottles",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Divider(),
                          Text(
                            "Wine Tumblers",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () => Get.to(const ContactInfo()),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
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
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const Center(
                      child: Text(
                        "Contact Us",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
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
