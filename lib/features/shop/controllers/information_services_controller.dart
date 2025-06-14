import 'package:elue_store/data/repositories/information_service/informaiton_service_repository.dart';
import 'package:elue_store/features/personalization/models/information_service_model.dart';
import 'package:elue_store/utils/popups/loaders.dart';
import 'package:get/get.dart';

class InformationServicesController extends GetxController {
  RxList serviceCategories = <ServiceCategoryModel>[].obs;
  RxList services = <ServiceModel>[].obs;
  RxBool isLoading = true.obs;
  final _serviceCategoryRepository = Get.put(InformaitonServiceRepository());

  @override
  void onInit() {
    super.onInit();
    fetchServiceCategories();
  }

  Future<void> fetchServiceCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      final fetchedServiceCategories =
          await _serviceCategoryRepository.getAllServiceCategories();
      // Update the categories list
      serviceCategories.assignAll(fetchedServiceCategories);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchServicesByCategory(int serviceCategoryId) async {
    try {
      // Show loader while loading services
      isLoading.value = true;

      final fetchedServices = await _serviceCategoryRepository
          .getServicesByCategory(serviceCategoryId);
      // Update the services list
      services.assignAll(fetchedServices);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshServiceCategory() async {
    try {
      isLoading.value = true;
      serviceCategories.clear();

      // Fetch new service categories
      final fetchedServiceCategories =
          await _serviceCategoryRepository.getAllServiceCategories();
      serviceCategories.assignAll(fetchedServiceCategories);
    } catch (e) {
      print('Error refreshing service categories: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
