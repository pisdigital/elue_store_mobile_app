import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  /// Empty Helper Function
  static SubCategoryModel empty() => SubCategoryModel(id: '', image: '', name: '', isFeatured: false);


  /// Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory SubCategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map JSON Record to the Model
      return SubCategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return SubCategoryModel.empty();
    }
  }

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
  // Convert parentId to String if it’s an int
  String parentId = json['parentId'] is int ? json['parentId'].toString() : json['parentId'] ?? '';

  return SubCategoryModel(
    id: json['id'].toString(),
    name: json['name'],
    image: json['image'],
    parentId: parentId,
    isFeatured: json['isFeatured'],
  );
}
}
