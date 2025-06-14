import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../utils/formatters/formatter.dart';

/// Model class representing user data.
class ServiceCategoryModel {
  final int id;
  final String title;
  final String thumbnail;
  final String banner;

  /// Constructor for ImageModel.
  ServiceCategoryModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.banner,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'banner': banner,
    };
  }

  /// Factory method to create a ServiceCategoryModel from JSON data
  static ServiceCategoryModel fromJson(Map<String, dynamic> json) {
    return ServiceCategoryModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      thumbnail: json['thumbnail']?.toString() ?? '',
      banner: json['banner']?.toString() ?? '',
    );
  }
}

class ServiceModel {
  final int id;
  final int categoryId;
  final String title;
  final String thumbnail;
  final String link;
  final String linkType;
  final String description;

  /// Constructor for ServiceModel
  ServiceModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.thumbnail,
    required this.link,
    required this.linkType,
    required this.description,
  });

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'thumbnail': thumbnail,
      'link': link,
      'linkType': linkType,
      'description': description,
    };
  }

  /// Factory method to create a ServiceModel from JSON
  static ServiceModel fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      title: json['title']?.toString() ?? '',
      thumbnail: json['thumbnail']?.toString() ?? '',
      link: json['link']?.toString() ?? '',
      linkType: json['linkType']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }
}
