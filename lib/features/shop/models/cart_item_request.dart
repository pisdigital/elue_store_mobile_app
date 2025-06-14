class CartItemRequest {
  final int productId;
  final String title;
  final double price;
  final int quantity;
  final String? variationId;
  final String? brandName; // Optional
  final String? selectedVariation; // Optional

  CartItemRequest({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    this.variationId,
    this.brandName,
    this.selectedVariation,
  });

  // Factory constructor to create an instance from a JSON object
  factory CartItemRequest.fromJson(Map<String, dynamic> json) {
    return CartItemRequest(
      productId: json['productId'],
      title: json['title'],
      price: json['price'],
      quantity: json['quantity'],
      variationId: json['variationId'],
      brandName: json['brandName'], // Optional
      selectedVariation: json['selectedVariation'], // Optional
    );
  }

  // Method to convert the instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'quantity': quantity,
      'variationId': variationId,
      if (brandName != null) 'brandName': brandName, // Include only if not null
      if (selectedVariation != null) 'selectedVariation': selectedVariation, // Include only if not null
    };
  }
}
