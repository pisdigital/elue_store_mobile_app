import 'package:elue_store/features/shop/models/category_model.dart';
import 'package:elue_store/utils/exceptions/firebase_exceptions.dart';
import 'package:elue_store/utils/http/http_client.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/sub_category_model.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  // final _db = FirebaseFirestore.instance;

  /* ---------------------------- FUNCTIONS ---------------------------------*/

  /// Get all categories
  // Future<List<CategoryModel>> getAllCategories() async {
  //   try {
  //    final result = await THttpHelper.get('categories/');
  //     final List<dynamic> categoryList = result;
  //     return categoryList
  //         .map((categoryJson) =>
  //             CategoryModel.fromJson(categoryJson as Map<String, dynamic>))
  //         .toList();
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }
  /// Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final result = await THttpHelper.get('parent-categories/');
    print("{obje333ct}");
    print(result);
      final List<dynamic> categoryList = result;
      return categoryList
          .map((categoryJson) =>
              CategoryModel.fromJson(categoryJson as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //sub-categories
  Future<List<SubCategoryModel>> getAllSubCategories() async {
    try {
      final result = await THttpHelper.get('categories/');
      final List<dynamic> subCategoryList = result;
      return subCategoryList
          .map((subCategoryJson) => SubCategoryModel.fromJson(
              subCategoryJson as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Featured categories
  Future<List<SubCategoryModel>> getSubCategories(String categoryId) async {
    try {
      // final result = await THttpHelper.get('categories/?parentId=$categoryId');
      final result = await THttpHelper.get('categories/');
      final List<dynamic> subCategoryList = result;
      return subCategoryList
          .map((subCategoryJson) => SubCategoryModel.fromJson(
              subCategoryJson as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Featured categories
  // Future<List<CategoryModel>> getSubCategories(String categoryId) async {
  //   try {
  //     final snapshot = await _db
  //         .collection("Categories")
  //         .where('ParentId', isEqualTo: categoryId)
  //         .get();
  //     final result =
  //         snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
  //     return result;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }
}
