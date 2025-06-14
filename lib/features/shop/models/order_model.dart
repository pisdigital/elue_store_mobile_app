import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../personalization/models/address_model.dart';
import 'cart_item_model.dart';

class OrderModel {
  final int id;
  final String userId;
  final String status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final int paymentMethod;
  final String? shippingAddress;
  final String? billingAddress;
  final DateTime? deliveryDate;
  final BigItems bigItems;
  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.bigItems,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxCost,
    required this.orderDate,
    required this.paymentMethod,
    this.billingAddress,
    this.shippingAddress,
    this.deliveryDate,
    this.billingAddressSameAsShipping = true,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.DELIVERED
      ? 'Delivered'
      : status == OrderStatus.CONFIRMED
          ? 'Order Confirmed'
          : 'Processing';

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'] ?? '',
      status: json['OrderStatus'] ?? '',
      totalAmount:
          double.tryParse(json['totalAmount']?.toString() ?? '0.0') ?? 0.0,
      shippingCost:
          double.tryParse(json['shippingCost']?.toString() ?? '0.0') ?? 0.0,
      taxCost: double.tryParse(json['taxCost']?.toString() ?? '0.0') ?? 0.0,
      orderDate: DateTime.parse(json['orderDate']),
      paymentMethod: json['paymentMethod'],
      billingAddressSameAsShipping:
          json['billingAddressSameAsShipping'] ?? true,
      billingAddress: json['billingAddress'],
      shippingAddress: json['shippingAddress'],
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
      bigItems: BigItems.fromJson(json['items']),
    );
  }
}

class BigItems {
  final int id;
  final List<CartItemRespModel> items;

  BigItems({required this.id, required this.items});
  factory BigItems.fromJson(Map<String, dynamic> json) {
    return BigItems(
      id: json['id'] ?? 0,
      items: (json['items'] as List<dynamic>?)
              ?.map((itemData) =>
                  CartItemRespModel.fromJson(itemData as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class CartItemRespModel {
  final int id;
  final ProductResp productId;
  final String title;
  final double price;
  final int quantity;
  final String? variationId;
  // final String? brandName;
  final String? selectedVariation;

  CartItemRespModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    this.variationId,
    // this.brandName,
    this.selectedVariation,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId.toJson(),
      'title': title,
      'price': price,
      'quantity': quantity,
      'variationId': variationId,
      // 'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  factory CartItemRespModel.fromJson(Map<String, dynamic> json) {
    return CartItemRespModel(
      id: json['id'] ?? 0,
      productId: ProductResp.fromJson(json['productId'] ?? {}),
      title: json['title'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
      quantity: json['quantity'] ?? 1,
      variationId: json['variationId'],
      // brandName: json['brandName'],
      selectedVariation: json['selectedVariation'],
    );
  }
}

class ProductResp {
  final int id;
  final double stock;
  final String? sku;
  final double price;
  final String title;
  final int soldQuantity;
  final double salePrice;
  final String thumbnail;
  final bool isFeatured;
  final int? brand;
  final int categoryId;
  final String productType;
  final String description;
  final List<CustomImage> images;
  final dynamic productAttributes;
  final dynamic productVariations;

  ProductResp({
    required this.id,
    required this.stock,
    this.sku,
    required this.price,
    required this.title,
    required this.soldQuantity,
    required this.salePrice,
    required this.thumbnail,
    required this.isFeatured,
    this.brand,
    required this.categoryId,
    required this.productType,
    required this.description,
    required this.images,
    this.productAttributes,
    this.productVariations,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stock': stock,
      'sku': sku,
      'price': price,
      'title': title,
      'soldQuantity': soldQuantity,
      'salePrice': salePrice,
      'thumbnail': thumbnail,
      'isFeatured': isFeatured,
      'brand': brand,
      'categoryId': categoryId,
      'productType': productType,
      'description': description,
      'images': images.map((image) => image.toJson()).toList(),
      'productAttributes': productAttributes,
      'productVariations': productVariations,
    };
  }

  factory ProductResp.fromJson(Map<String, dynamic> json) {
    print("387373773");
    print(json['brand'].runtimeType);
    return ProductResp(
      id: json['id'] ?? 0,
      stock: json['stock']?.toDouble() ?? 0.0,
      sku: json['sku'],
      price: double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
      title: json['title'] ?? '',
      soldQuantity: json['soldQuantity'] ?? 0,
      salePrice: double.tryParse(json['salePrice']?.toString() ?? '0.0') ?? 0.0,
      thumbnail: json['thumbnail'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      brand: json['brand'],
      categoryId: json['categoryId'] ?? 0,
      productType: json['productType'] ?? '',
      description: json['description'] ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((imageData) =>
                  CustomImage.fromJson(imageData as Map<String, dynamic>))
              .toList() ??
          [],
      productAttributes: json['productAttributes'],
      productVariations: json['productVariations'],
    );
  }
}

class CustomImage {
  final int id;
  final String image;

  CustomImage({required this.id, required this.image});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }

  factory CustomImage.fromJson(Map<String, dynamic> json) {
    return CustomImage(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}
