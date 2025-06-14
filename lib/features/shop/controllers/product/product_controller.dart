import 'package:elue_store/utils/constants/enums.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  Rx<ProductModel> productById = ProductModel.empty().obs;

  /// -- Initialize Products from your backend
  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void clearProductById() async {
    print("999999999999999999999999999999999999999999999999999999999999");
    productById.value = ProductModel.empty();
  }

  Future<void> refreshProducts() async {
    try {
      isLoading.value = true;
      // Clear existing products
      featuredProducts.clear();

      // Fetch new products
      final products = await ProductRepository.instance.getFeaturedProducts();
      featuredProducts.assignAll(products);
    } catch (e) {
      print('Error refreshing products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch Products using Stream so, any change can immediately take effect.
  void fetchFeaturedProducts() async {
    try {
      // Show loader while loading Products
      isLoading.value = true;

      // Fetch Products
      final products = await productRepository.getFeaturedProducts();

      // Assign Products
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<ProductModel> fetchProductById(int id) async {
    try {
      // Show loader while loading Products
      isLoading.value = true;

      // Fetch Product
      final product = await productRepository.getProductById(id);
      return product;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      throw Exception(
          'Failed to fetch product by ID'); // Explicitly throw an exception
    } finally {
      isLoading.value = false;
    }
  }

  /// Get the product price or price range for variations.
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    // If no variations exist, return the simple price or sale price
    if (product.productType == ProductType.single.toString() ||
        product.productVariations == null) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    } else {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    }
    //  else {
    //   // Calculate the smallest and largest prices among variations
    //   for (var variation in product.productVariations!) {
    //     // Determine the price to consider (sale price if available, otherwise regular price)
    //     double priceToConsider =
    //         variation.salePrice > 0.0 ? variation.salePrice : variation.price;

    //     // Update smallest and largest prices
    //     if (priceToConsider < smallestPrice) {
    //       smallestPrice = priceToConsider;
    //     }

    //     if (priceToConsider > largestPrice) {
    //       largestPrice = priceToConsider;
    //     }
    //   }

    //   // If smallest and largest prices are the same, return a single price
    //   if (smallestPrice.isEqual(largestPrice)) {
    //     return largestPrice.toString();
    //   } else {
    //     // Otherwise, return a price range
    //     return '$smallestPrice - \$$largestPrice';
    //   }
    // }
  }

  /// -- Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// -- Check Product Stock Status
  String getProductStockStatus(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      return product.stock > 0 ? 'In Stock' : 'Out of Stock';
    } else {
      final stock = product.productVariations
          ?.fold(0, (previousValue, element) => previousValue + element.stock);
      return stock != null && stock > 0 ? 'In Stock' : 'Out of Stock';
    }
  }
}
