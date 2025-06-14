import 'package:elue_store/features/shop/screens/home/widgets/info_cards.dart';
import 'package:elue_store/features/shop/screens/home/widgets/information_service_detail.dart';
import 'package:elue_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elue_store/features/shop/controllers/information_services_controller.dart';

class InformationServicesWidget extends StatelessWidget {
  const InformationServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final InformationServicesController controller =
        Get.put(InformationServicesController());

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: TColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        } else if (controller.serviceCategories.isEmpty) {
          return Text('No Data Found!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: Colors.white));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Information & Services",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(height: 30.0),
              ...controller.serviceCategories.map((category) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.fetchServicesByCategory(category.id);
                        Get.to(InformationServiceDetail(
                            title: category.title,
                            services: controller.services,
                            serviceCategory: category));
                      },
                      child: InfoCards(
                        title: category.title,
                        icon: category.thumbnail,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                );
              }).toList(),
              const Text(
                "All Rights Reserved © Eluestore 2024",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          );
        }
      }),
    );
  }
}
