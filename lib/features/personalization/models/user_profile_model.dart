import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/formatters/formatter.dart';
import '../../shop/models/cart_model.dart';
import 'address_model.dart';

/// Model class representing user data.
class UserProfileModel {
  // Keep those values final which you do not want to update
  final String id;
  // String firstName;
  String? bio;
  // final String username;
  final String email;
  String phoneNumber;
  String? location;
  // String profilePicture;
  // final CartModel? cart;
  // final List<AddressModel>? addresses;
  // AppRole role;
  // DateTime? createdAt;
  // DateTime? updatedAt;

  /// Constructor for UserProfileModel.
  UserProfileModel({
    required this.id,
    // required this.firstName,
    this.bio,
    this.location,
    // required this.username,
    required this.email,
    required this.phoneNumber,
    // required this.profilePicture,
    // this.cart,
    // this.addresses,
    // this.role = AppRole.user,
    // this.createdAt,
    // this.updatedAt,
  });

  /// Helper function to get the full name.
  // String get fullName => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model.
  static UserProfileModel empty() => UserProfileModel(
        id: '',
        email: '',
        bio: '',
        phoneNumber: '',
      );

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      // 'FirstName': firstName,
      // 'LastName': lastName,
      // 'Username': username,
      'id': id,
      'email': email,
      'phone_number': "000",
      'bio': "",
      'location': ''
      // 'ProfilePicture': profilePicture,
      // 'Role': AppRole.user.name,
      // 'CreatedAt': createdAt = DateTime.now(),
      // 'UpdatedAt': DateTime.now(),
    };
  }

  /// Factory method to create a UserProfileModel from a Firebase document snapshot.
  factory UserProfileModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserProfileModel(
        id: document.id,
        bio: data['bio'] ?? '',
        location: data['location'] ?? '',
        // username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        // profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserProfileModel.empty();
    }
  }
}
