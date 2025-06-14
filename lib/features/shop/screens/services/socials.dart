import 'package:elue_store/common/widgets/appbar/appbar.dart';
import 'package:elue_store/utils/constants/image_strings.dart';
import 'package:elue_store/utils/constants/sizes.dart';
import 'package:elue_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class Socials extends StatelessWidget {
  const Socials({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Socials',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 10,
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
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const Text(
                      "Link Tree",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )),
                const SizedBox(
                  height: 40.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      sizedBox:false,
                      textSize: 11.0,
                      imageWidth: 50.0,
                      imageHeight: 50.0,
                      content: "+251906648690",
                      image: TImages.whatsapp,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SocialCard(
                      sizedBox:false,
                      textSize: 11.0,
                      imageWidth: 50.0,
                      imageHeight: 50.0,
                      content: "+251906648690",
                      image: TImages.telegram,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      sizedBox:false,
                      textSize: 12.0,
                      imageWidth: 50.0,
                      imageHeight: 50.0,
                      content: "Facebook",
                      image: TImages.facebookBlack,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SocialCard(
                      sizedBox:true,
                      textSize: 12.0,
                      imageWidth: 25.0,
                      imageHeight: 25.0,
                      content: "Instagram",
                      image: TImages.instagram,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      sizedBox:false,
                      textSize: 12.0,
                      imageWidth: 50.0,
                      imageHeight: 50.0,
                      content: "TikTok",
                      image: TImages.tiktok,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SocialCard(
                      sizedBox:false,
                      textSize: 12.0,
                      imageWidth: 50.0,
                      imageHeight: 50.0,
                      content: "YouTube",
                      image: TImages.youtube,
                    ),
                  ],
                ),
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

class SocialCard extends StatelessWidget {
  const SocialCard(
      {super.key,
      required this.content,
      required this.image,
      required this.sizedBox,
      required this.textSize,
      required this.imageWidth,
      required this.imageHeight});
  final String content;
  final String image;
  final double textSize;
  final bool sizedBox;
  final double imageWidth;
  final double imageHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 155,
        alignment: Alignment.center,
        // margin: const EdgeInsets.symmetric(horizontal: 50.0),
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
            Image(
              width: imageWidth,
              height: imageHeight,
              image: AssetImage(image),
            ),
            sizedBox
                ? const SizedBox(
                    height: 12,
                  )
                : const SizedBox(
                    height: 0,
                  ),
            Text(
              content,
              style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }
}
