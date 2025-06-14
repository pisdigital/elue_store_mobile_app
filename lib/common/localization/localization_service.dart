import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Map<String, Map<String, String>> translations = {
  'ET': {
    'currency': 'ETB',
  },
  'US': {
    'currency': '\$',
  },
};

class LocalizationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => translations;

  // Dynamically change locale
  void changeLocale(String server) {
    if (server == 'ET') {
      Get.updateLocale(const Locale('am', 'ET')); // Ethiopia
    } else if (server == 'US') {
      Get.updateLocale(const Locale('en', 'US')); // USA
    }
  }
}
