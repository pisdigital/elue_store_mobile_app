import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class BannerModel {
  String imageUrl;
  final String targetScreen;
  final bool active;

  BannerModel(
      {required this.imageUrl,
      required this.targetScreen,
      required this.active});

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'targetScreen': targetScreen,
      'active': active,
    };
  }

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    final logger = Logger();
    logger.d('Fetched Banner List:$json');
    return BannerModel(
      imageUrl: json['imageUrl'] ?? '',
      targetScreen: json['targetScreen'] ?? '',
      active: json['active'] ?? false,
    );
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      imageUrl: data['imageUrl'] ?? '',
      targetScreen: data['targetScreen'] ?? '',
      active: data['active'] ?? false,
    );
  }
}
