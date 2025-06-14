import 'package:country_flags/country_flags.dart';
import 'package:elue_store/features/authentication/controllers/store_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreSelectionDropdown extends StatelessWidget {
  const StoreSelectionDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreSelectionController controller =
        Get.put(StoreSelectionController());
    return Obx(() => DropdownButton<String>(
          value: controller.selectedStore.value, // Currently selected store
          icon: const SizedBox.shrink(),
          iconSize: 0,
          elevation: 16,
          style: const TextStyle(color: Colors.black),

          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.changeStore(newValue); // Update the store on change
            }
          },
          items: [
            DropdownMenuItem<String>(
              value: controller.selectedStore.value,
              child: Row(
                children: [
                  CountryFlag.fromCountryCode(
                    controller.selectedStore.value,
                    width: 30,
                    height: 25,
                    shape: const RoundedRectangle(6),
                  ),
                  const SizedBox(width: 8),
                  Text(controller.selectedStore.value,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
            ),
            DropdownMenuItem<String>(
              value: controller.getOppositeStore(),
              child: Row(
                children: [
                  CountryFlag.fromCountryCode(
                    controller.getOppositeStore(),
                    width: 30,
                    height: 25,
                    shape: const RoundedRectangle(6),
                  ),
                  const SizedBox(width: 8),
                  Text(controller.getOppositeStore(),
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
            ),
          ],
        ));
  }
}
