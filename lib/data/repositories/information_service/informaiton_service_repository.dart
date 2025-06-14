import 'package:elue_store/features/personalization/models/information_service_model.dart';
import 'package:elue_store/features/shop/models/category_model.dart';
import 'package:elue_store/utils/exceptions/firebase_exceptions.dart';
import 'package:elue_store/utils/http/http_client.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/sub_category_model.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class InformaitonServiceRepository extends GetxController {
  static InformaitonServiceRepository get instance => Get.find();

  Future<List<ServiceCategoryModel>> getAllServiceCategories() async {
    try {
      final result = await THttpHelper.get('services-categroy/');
      print("{obje333ct}");
      print(result);
      final List<dynamic> serviceCategoryList = result;
      return serviceCategoryList
          .map((serviceCategoryJson) => ServiceCategoryModel.fromJson(
              serviceCategoryJson as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ServiceModel>> getServicesByCategory(
      int serviceCategoryId) async {
    try {
      final result =
          await THttpHelper.get('services/?categoryId=$serviceCategoryId');

      print("99999999999");
      print(result);
      final List<dynamic> services = result;
      return services
          .map((servicesJson) =>
              ServiceModel.fromJson(servicesJson as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
