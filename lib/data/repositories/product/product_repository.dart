import 'dart:io';
import 'package:elue_store/data/repositories/brands/brand_repository.dart';
import 'package:elue_store/features/shop/models/search_response_model.dart';
import 'package:elue_store/utils/http/http_client.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/product_model.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../services/cloud_storage/firebase_storage_service.dart';
import 'package:path/path.dart' as path;

/// Repository for managing product-related data and operations.
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Firestore instance for database interactions.
  final _db = FirebaseFirestore.instance;

  /* ---------------------------- FUNCTIONS ---------------------------------*/

  /// Get limited featured products.
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final result = await THttpHelper.get('products/');
      final List<dynamic> productList = result;
      print({"MMMM"});
      print({productList});
      return productList
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print({"MMMM"});
      print({e});
      throw 'Something went wrong. Please try again';
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      final result = await THttpHelper.get('products/$id/');
      // final List<dynamic> productList = result;
      print({"MMMM"});
      // print({productList});
      return ProductModel.fromJson(result);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print({"MMMM"});
      print({e});
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get limited featured products.
  Future<ProductModel> getSingleProduct(String productId) async {
    try {
      final snapshot = await _db.collection('Products').doc(productId).get();
      return ProductModel.fromSnapshot(snapshot);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all featured products using Stream.
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    final snapshot = await _db
        .collection('Products')
        .where('IsFeatured', isEqualTo: true)
        .get();
    return snapshot.docs
        .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
        .toList();
  }

  /// Get Products based on the Brand
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get favorite products based on a list of product IDs.
  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetches products for a specific category.
  /// If the limit is -1, retrieves all products for the category; otherwise, limits the result based on the provided limit.
  /// Returns a list of [ProductModel] objects.
  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      final result = await THttpHelper.get('products?categoryId=$categoryId');
      final List<dynamic> productList = result;

      var finalProductList = productList
          .map((productJson) =>
              ProductModel.fromJson(productJson as Map<String, dynamic>))
          .toList();
      return finalProductList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print("78787878");
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetches products for a specific brand.
  /// If the limit is -1, retrieves all products for the brand; otherwise, limits the result based on the provided limit.
  /// Returns a list of [ProductModel] objects.
  Future<List<ProductModel>> getProductsForBrand(
      String brandId, int limit) async {
    try {
      // Query to get all documents where productId matches the provided categoryId & Fetch limited or unlimited based on limit
      QuerySnapshot<Map<String, dynamic>> querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();

      // Map Products
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Future<List<ProductModel>> searchProducts(String query,
  //     {String? categoryId,
  //     String? brandId,
  //     double? minPrice,
  //     double? maxPrice}) async {
  //   try {
  //     // Reference to the 'products' collection in Firestore
  //     CollectionReference productsCollection =
  //         FirebaseFirestore.instance.collection('Products');

  //     // Start with a basic query to search for products where the name contains the query
  //     Query queryRef = productsCollection;

  //     // Apply the search filter
  //     if (query.isNotEmpty) {
  //       queryRef = queryRef
  //           .where('Title', isGreaterThanOrEqualTo: query)
  //           .where('Title', isLessThanOrEqualTo: '$query\uf8ff');
  //     }

  //     // Apply filters
  //     if (categoryId != null) {
  //       queryRef = queryRef.where('CategoryId', isEqualTo: categoryId);
  //     }

  //     if (brandId != null) {
  //       queryRef = queryRef.where('Brand.Id', isEqualTo: brandId);
  //     }

  //     if (minPrice != null) {
  //       queryRef = queryRef.where('Price', isGreaterThanOrEqualTo: minPrice);
  //     }

  //     if (maxPrice != null) {
  //       queryRef = queryRef.where('Price', isLessThanOrEqualTo: maxPrice);
  //     }

  //     // Execute the query
  //     QuerySnapshot querySnapshot = await queryRef.get();

  //     // Map the documents to ProductModel objects
  //     final products = querySnapshot.docs
  //         .map((doc) => ProductModel.fromQuerySnapshot(doc))
  //         .toList();

  //     return products;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }
  Future<List<SearchResponseModel>> searchProducts(String query,
      {String? categoryId,
      String? brandId,
      double? minPrice,
      double? maxPrice}) async {
    try {
      // Construct the query parameters
      final Map<String, dynamic> queryParams = {
        'query': query,
        if (categoryId != null) 'categoryId': categoryId,
        if (brandId != null) 'brandId': brandId,
        if (minPrice != null) 'minPrice': minPrice,
        if (maxPrice != null) 'maxPrice': maxPrice,
      };

      // Perform the HTTP GET request
      final result = await THttpHelper.get('productsearch?query=$query');
      final List<dynamic> productList = result;

      return productList
          .map((productJson) => SearchResponseModel.fromJson(productJson))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }

  // Future<List<ProductModel>> getFeaturedProducts() async {
  //   try {
  //     final result = await THttpHelper.get('products/');
  //     final List<dynamic> productList = result;
  //     print({"MMMM"});
  //     print({productList});
  //     return productList
  //         .map((productJson) => ProductModel.fromJson(productJson))
  //         .toList();
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     print({"MMMM"});
  //     print({e});
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  /// Update any field in specific Collection
  Future<void> updateSingleField(
      String docId, Map<String, dynamic> json) async {
    try {
      await _db.collection("Products").doc(docId).update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update product.
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db.collection('Products').doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
