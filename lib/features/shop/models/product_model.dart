import 'package:cloud_firestore/cloud_firestore.dart';

import 'brand_model.dart';
import 'product_attribute_model.dart';
import 'product_variation_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  int soldQuantity;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  // BrandModel? brand;
  int? brand;
  int? categoryId;
  String productType;
  String? description;
  List<ImageModel>? images;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.soldQuantity = 0,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(
      id: '',
      title: '',
      stock: 0,
      price: 0,
      thumbnail: '',
      productType: '',
      soldQuantity: 0);

  /// Json Format
  toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail.toString(),
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      // 'Brand': brand!.toJson(),
      'Description': description,
      'ProductType': productType,
      'SoldQuantity': soldQuantity,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      title: data['Title'],
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'],
      stock: data['Stock'] ?? 0,
      soldQuantity: data['SoldQuantity'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: (data['Brand']),
      images:
          data['Images'] != null ? List<ImageModel>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'])
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'])
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  // Map Json-oriented document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      title: data['Title'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'] ?? '',
      stock: data['Stock'] ?? 0,
      soldQuantity: data['SoldQuantity'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: (data['Brand']),
      images:
          data['Images'] != null ? List<ImageModel>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'])
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'])
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      stock: json['stock'] ?? 0,
      sku: json['sku'],
      price: double.parse(json['price'].toString()),
      title: json['title'],
      soldQuantity: json['soldQuantity'] ?? 0,
      salePrice: double.parse(json['salePrice'].toString()),
      thumbnail: json['thumbnail'].toString(),
      isFeatured: json['isFeatured'] ?? false,
      brand: json['brand'],
      categoryId: json['categoryId'],
      productType: json['productType'],
      description: json['description'],
      images: json['images'] != null
          ? (json['images'] as List)
              .map((imageJson) => ImageModel.fromJson(imageJson))
              .toList()
          : [],
      productAttributes: [],
      // json['productAttributes'] != null && json['productAttributes'] is List
      //     ? (json['productAttributes'] as List)
      //         .map((e) => ProductAttributeModel.fromJson(e))
      //         .toList()
      //     : [],
      productVariations: [],
      // json['productVariations'] != null && json['productVariations'] is List
      //     ? (json['productVariations'] as List)
      //         .map((e) => ProductVariationModel.fromJson(e))
      //         .toList()
      //     : [],
    );
  }
}

class ImageModel {
  final int? id;
  final String? image;

  ImageModel({
    this.id,
    this.image,
  });

  // Convert ImageModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }

  // Create ImageModel from JSON
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      image: json['image'],
    );
  }
}
