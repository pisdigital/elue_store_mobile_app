class CartItemResponse {
  int id;
  int productId; // Change to int to match the nested object structure
  String title;
  double price;
  String? image;
  int quantity;
  String? variationId; // Optional to handle null values
  String? brandName;   // Optional
  String? selectedVariation; // Optional

  /// Constructor
  CartItemResponse({
    required this.id,
    required this.productId,
    required this.quantity,
    this.variationId,
    this.image,
    required this.price,
    required this.title,
    this.brandName,
    this.selectedVariation,
  });

  /// Empty Cart
  static CartItemResponse empty() => CartItemResponse(id: 0, productId: 0, quantity: 0, price: 0.0, title: '');

  /// Convert a CartItem to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  /// Create a CartItem from a JSON Map
  factory CartItemResponse.fromJson(Map<String, dynamic> json) {
    return CartItemResponse(
      id: json['id'],
      productId: json['productId']['id'], // Extract the `id` from the nested object
      title: json['title'],
      price: double.parse(json['price']), // Safely cast to double
      image: json['productId']['thumbnail'], // Optional: Extract the image if needed
      quantity: json['quantity'],
      variationId: json['variationId'],
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation'],
    );
  }
}
