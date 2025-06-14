import 'package:country_flags/country_flags.dart';
import 'package:elue_store/common/widgets/appbar/appbar.dart';
import 'package:elue_store/utils/constants/image_strings.dart';
import 'package:elue_store/utils/constants/sizes.dart';
import 'package:elue_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class Design extends StatelessWidget {
  const Design({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Design & Development',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width -100,
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
                          "Website Development",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width -100,
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
                          "Website Design",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width -100,
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
                          "Application Design",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
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
      ),
    );
  }
}
