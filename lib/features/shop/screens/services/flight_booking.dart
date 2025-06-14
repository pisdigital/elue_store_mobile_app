import 'package:country_flags/country_flags.dart';
import 'package:elue_store/common/widgets/appbar/appbar.dart';
import 'package:elue_store/utils/constants/image_strings.dart';
import 'package:elue_store/utils/constants/sizes.dart';
import 'package:elue_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class FlightBooking extends StatelessWidget {
  const FlightBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Flight Booking',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              width: THelperFunctions.screenWidth() * 0.8,
              height: THelperFunctions.screenHeight() * 0.2,
              image: const AssetImage(TImages.flightService),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CountryFlag.fromCountryCode(
                      'US',
                      width: 30,
                      height: 25,
                      // shape: const RoundedRectangle(6),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    const Text(
                      "USA CUSTOMER SERVICE NUMBER",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0),
                  padding: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 15,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Column(
                    children: [
                      Text(
                        "206-375-7327",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Divider(),
                      Text(
                        "206-535-0886",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
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
