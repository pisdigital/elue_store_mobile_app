class OrderRequest {
  final String userId;
  final String orderStatus;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final int paymentMethod;
  final String shippingAddress;
  final String billingAddress;
  final int items;
  final bool billingAddressSameAsShipping;

  /// Constructor
  OrderRequest({
    required this.userId,
    required this.orderStatus,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxCost,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.billingAddress,
    required this.items,
    required this.billingAddressSameAsShipping,
  });

  /// Create an instance from JSON
  factory OrderRequest.fromJson(Map<String, dynamic> json) {
    return OrderRequest(
      userId: json['userId'],
      orderStatus: json['OrderStatus'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      shippingCost: (json['shippingCost'] as num).toDouble(),
      taxCost: (json['taxCost'] as num).toDouble(),
      paymentMethod: json['paymentMethod'],
      shippingAddress: json['shippingAddress'],
      billingAddress: json['billingAddress'],
      items: json['items'],
      billingAddressSameAsShipping: json['billingAddressSameAsShipping'],
    );
  }

  /// Convert to JSON
  Map<String, String> toJson() {
    return {
      'userId': userId,
      'OrderStatus': orderStatus,
      'totalAmount': totalAmount.toString(),
      'shippingCost': shippingCost.toString(),
      'taxCost': taxCost.toString(),
      'paymentMethod': paymentMethod.toString(),
      'shippingAddress': shippingAddress,
      'billingAddress': billingAddress,
      'items': items.toString(),
      'billingAddressSameAsShipping': billingAddressSameAsShipping.toString(),
    };
  }
}
