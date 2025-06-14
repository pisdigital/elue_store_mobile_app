import 'package:elue_store/features/shop/controllers/categories_controller.dart';
import 'package:elue_store/features/shop/controllers/information_services_controller.dart';
import 'package:elue_store/features/shop/controllers/product/cart_controller.dart';
import 'package:elue_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:elue_store/features/shop/controllers/product/product_controller.dart';
import 'package:elue_store/home_menu.dart';
import 'package:elue_store/utils/constants/api_constants.dart';
import 'package:elue_store/utils/constants/text_strings.dart';
import 'package:elue_store/utils/http/http_client.dart';
import 'package:elue_store/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StoreSelectionController extends GetxController {
  static StoreSelectionController get instance => Get.find();
  final localStorage = GetStorage(); // Initialize GetStorage
  final RxString selectedStore = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedStore.value = localStorage.read('selectedStore') ?? '';
  }

  // Method to store selected option
  void saveSelectedStore(String countryCode, bool redirectToHome) async {
    await localStorage.write(
        'selectedStore', countryCode); // Store the country code
    selectedStore.value = countryCode;
    changeStore(countryCode);
    countryCode == TTexts.etStore
        ? localStorage.write('currency', TTexts.etCurrency)
        : localStorage.write('currency', TTexts.usCurrency);
    // LocalizationService().changeLocale(countryCode);
    //writing base url to local storage
    final baseUrl = countryCode == TTexts.etStore
        ? TAPIs.etStoreAPIURL
        : TAPIs.usStoreAPIURL;
    localStorage.write('baseUrl', baseUrl);
    TLoaders.successGreenSnackBar(
        title: 'Store Selected', message: "You selected $countryCode");

    if (redirectToHome) {
      Get.offAll(() => const HomeMenu());
    }
  }

  // Method to change store and store it locally
  void changeStore(String storeCode) async {
    try {
      selectedStore.value = storeCode;
      String selected = storeCode == 'ET' ? TTexts.etStore : TTexts.usStore;

      // Update local storage
      localStorage.write('selectedStore', selected);
      changeCurrency(selected);

      // Update API base URL based on store
      final baseUrl = selected == TTexts.etStore
          ? TAPIs.etStoreAPIURL
          : TAPIs.usStoreAPIURL;
      localStorage.write('baseUrl', baseUrl);
      THttpHelper.updateBaseUrl(baseUrl);

      // Reset and refresh all controllers
      await _refreshControllers();

      TLoaders.successGreenSnackBar(
          title: 'Store Changed', message: "You selected $selected Store");
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: "Failed to change store: $e");
    }
  }

  // Helper method to refresh all controllers
  Future<void> _refreshControllers() async {
    // Reset Product Controller
    if (Get.isRegistered<ProductController>()) {
      final productController = Get.find<ProductController>();
      await productController.refreshProducts();
      final cartController = Get.find<CartController>();
      final checkoutController = Get.find<CheckoutController>();
      final informationServiceController =
          Get.put(InformationServicesController());
      informationServiceController.refreshServiceCategory();
      cartController.clearCart();
      checkoutController.fetchPaymentMethods();
    }

    if (Get.isRegistered<CategoryController>()) {
      final categoryController = Get.find<CategoryController>();
      await categoryController.refreshCategories();
    }
    // Force rebuild of the home screen
    Get.offAll(() => const HomeMenu());
  }

  // Method to retrieve the selected country (if needed)
  String? getSelectedStore() {
    return localStorage.read('selectedStore'); // Get the stored country code
  }

  String getOppositeStore() {
    return selectedStore.value == 'ET' ? 'US' : 'ET';
  }

  void changeCurrency(String store) {
    String currency =
        store == TTexts.etStore ? TTexts.etCurrency : TTexts.usCurrency;
    localStorage.write('currency', currency);
  }

  String getCurrency() {
    return localStorage.read('currency');
  }
}
