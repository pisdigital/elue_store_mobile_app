import 'package:country_flags/country_flags.dart';
import 'package:elue_store/common/styles/spacing_styles.dart';
import 'package:elue_store/features/authentication/controllers/store_selection_controller.dart';
import 'package:elue_store/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreSelection extends StatelessWidget {
  StoreSelection({super.key}){
    Get.put(StoreSelectionController());
  }

  @override
  Widget build(BuildContext context) {
   return GetBuilder<StoreSelectionController>(builder: (controller){
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(TTexts.storeSelectionTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: ()=>{controller.saveSelectedStore(TTexts.etStore, true)},
                    child: Column(children: [
                      CountryFlag.fromCountryCode(
                        'ET',
                        width: 100,
                        height: 80,
                        shape: const RoundedRectangle(6),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(TTexts.etStore,
                          style: Theme.of(context).textTheme.headlineSmall)
                    ]),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: ()=>{
                      controller.saveSelectedStore(TTexts.usStore, true)
                    },
                    child: Column(children: [
                      CountryFlag.fromCountryCode(
                        'US',
                        width: 100,
                        height: 80,
                        shape: const RoundedRectangle(6),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(TTexts.usStore,
                          style: Theme.of(context).textTheme.headlineSmall)
                    ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(TTexts.storeSelectionNotice,
                  style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
        ),
      ),
    );
  
   });
  }
}
