class CartResponse {
  final int id;
  final CartItem item; // Assuming the response contains one cart item

  CartResponse({
    required this.id,
    required this.item,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      id: json['id'],
      item: CartItem.fromJson(
          json), // Directly map the entire response to a CartItem
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item.toJson(),
    };
  }
}

class CartItem {
  final int id;
  final Product product;
  final String title;
  final double price;
  final int quantity;
  final String? variationId;
  final String? brandName;

  CartItem({
    required this.id,
    required this.product,
    required this.title,
    required this.price,
    required this.quantity,
    this.variationId,
    this.brandName,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      product: Product.fromJson(json['productId']),
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      variationId: json['variationId'],
      brandName: json['brandName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': product.toJson(),
      'title': title,
      'price': price,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
    };
  }
}

class Product {
  final int id;
  final int stock;
  final String? sku;
  final double price;
  final String title;
  final int soldQuantity;
  final double salePrice;
  final String thumbnail;
  final bool isFeatured;
  final Category category;
  final Brand brand;
  final String productType;
  final String description;
  final List<String> images;

  Product({
    required this.id,
    required this.stock,
    this.sku,
    required this.price,
    required this.title,
    required this.soldQuantity,
    required this.salePrice,
    required this.thumbnail,
    required this.isFeatured,
    required this.category,
    required this.brand,
    required this.productType,
    required this.description,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      stock: json['stock'],
      sku: json['sku'],
      price: (json['price'] as num).toDouble(),
      title: json['title'],
      soldQuantity: json['soldQuantity'],
      salePrice: (json['salePrice'] as num).toDouble(),
      thumbnail: json['thumbnail'],
      isFeatured: json['isFeatured'],
      category: Category.fromJson(json['categoryId']),
      brand: Brand.fromJson(json['brand']),
      productType: json['productType'],
      description: json['description'],
      images: List<String>.from(json['images']),
    );
  }

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
      'categoryId': category.toJson(),
      'brand': brand.toJson(),
      'productType': productType,
      'description': description,
      'images': images,
    };
  }
}

class Category {
  final int id;
  final String name;
  final String image;
  final bool isFeatured;
  final int? parentId;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      isFeatured: json['isFeatured'],
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'parentId': parentId,
    };
  }
}

class Brand {
  final String name;
  final String? image;
  final bool isFeatured;

  Brand({
    required this.name,
    this.image,
    required this.isFeatured,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      name: json['name'],
      image: json['image'],
      isFeatured: json['isFeatured'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
    };
  }
}
