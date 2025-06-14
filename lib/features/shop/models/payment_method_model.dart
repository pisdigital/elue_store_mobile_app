class PaymentMethodModel {
  final int? id;
  final String name;
  final String image;

  PaymentMethodModel({
    this.id,
    required this.name,
    required this.image,
  });

  static PaymentMethodModel empty() => PaymentMethodModel(name: '', image: '');

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
