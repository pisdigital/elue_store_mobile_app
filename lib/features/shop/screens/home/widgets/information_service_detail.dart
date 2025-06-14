import 'package:elue_store/common/widgets/appbar/appbar.dart';
import 'package:elue_store/common/widgets/images/t_rounded_image.dart';
import 'package:elue_store/features/personalization/models/information_service_model.dart';
import 'package:elue_store/features/shop/controllers/information_services_controller.dart';
import 'package:elue_store/utils/constants/colors.dart';
import 'package:elue_store/utils/constants/image_strings.dart';
import 'package:elue_store/utils/constants/sizes.dart';
import 'package:elue_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationServiceDetail extends StatelessWidget {
  const InformationServiceDetail(
      {super.key,
      required this.title,
      required this.services,
      required this.serviceCategory});
  final String title;
  final List<dynamic> services;
  final ServiceCategoryModel serviceCategory;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InformationServicesController>(builder: (controller) {
      return Scaffold(
        appBar: TAppBar(
            showBackArrow: true,
            title:
                Text(title, style: Theme.of(context).textTheme.headlineSmall)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: TColors.primary,
                        ),
                      );
                    }

                    if (controller.services.isEmpty) {
                      return const Center(
                        child: Text(
                          'No services found',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: TColors.primary),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        if (serviceCategory.banner.isNotEmpty)
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                left: TSizes.defaultSpace,
                                right: TSizes.defaultSpace,
                                bottom: TSizes.defaultSpace),
                            child: TRoundedImage(
                              imageUrl: serviceCategory.banner,
                              fit: BoxFit.cover,
                              isNetworkImage: true,
                              onPressed: () => {},
                            ),
                          ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            itemCount: controller.services.length,
                            itemBuilder: (context, index) {
                              final service = controller.services[index];

                              return InkWell(
                                onTap: () async {
                                  final service = controller.services[index];
                                  var link = service.link;

                                  if (service.linkType == 'WEBSITE') {
                                    if (!link.startsWith('http://') &&
                                        !link.startsWith('https://') &&
                                        !link.startsWith('www.')) {
                                      link = 'https://$link';
                                    }
                                    print('Link: $link');
                                    final Uri url = Uri.parse(link);
                                    print('URL: $url');
                                    try {
                                      if (true) {
                                        await launchUrl(url,
                                            mode:
                                                LaunchMode.externalApplication);
                                      }
                                      // else {
                                      //   Get.snackbar('Error',
                                      //       'Could not open URL: $link');
                                      // }
                                    } catch (e) {
                                      print('Error: $e');
                                      Get.snackbar(
                                          'Error', 'Invalid URL format: $link');
                                    }
                                  } else if (service.linkType ==
                                      'PHONE_NUMBER') {
                                    final Uri phoneUri = Uri.parse('tel:$link');
                                    if (await canLaunchUrl(phoneUri)) {
                                      await launchUrl(phoneUri);
                                    } else {
                                      Get.snackbar('Error',
                                          'Could not open phone dialer');
                                    }
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          30,
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            service.thumbnail,
                                            width: 60,
                                            height: 60,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  service.title,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  service.description,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  }),
                ),
                // Column(
                //   children: [
                //     Image(
                //       width: THelperFunctions.screenWidth() * 0.4,
                //       height: THelperFunctions.screenHeight() * 0.2,
                //       image: const AssetImage(TImages.lightAppLogo),
                //     ),
                //     const SizedBox(height: TSizes.spaceBtwItems),
                //     Text(
                //       "All Rights Reserved © Eluestore ${DateTime.now().year}",
                //       style: const TextStyle(fontSize: 12),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
