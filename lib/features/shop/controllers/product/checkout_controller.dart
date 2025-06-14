import 'dart:io';

import 'package:elue_store/features/personalization/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/payment_method_model.dart';
import '../../screens/checkout/widgets/payment_tile.dart';
import '../../../../utils/http/http_client.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final settingsController = Get.put(SettingsController());
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;
  final RxList<PaymentMethodModel> paymentMethods = <PaymentMethodModel>[].obs;
  Rx<File?> receiptFile = Rx<File?>(null);
  RxString receiptFileName = ''.obs;
  @override
  void onInit() {
    fetchPaymentMethods();
    super.onInit();
  }

  void clearController() {
    receiptFile.value = null;
    receiptFileName.value = '';
  }

  Future<void> uploadReceipt() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png'], // Specify allowed file types
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        receiptFile.value = file;
        receiptFileName.value = file.path.split('/').last;
      }
    } catch (e) {
      // Handle any errors that occur during file picking
      print('Error picking file: $e');
    }
  }

  Future<void> fetchPaymentMethods() async {
    try {
      final response = await THttpHelper.get('payment-methods/');
      final List<dynamic> paymentMethodsList = response;

      paymentMethods.value = paymentMethodsList
          .map((json) => PaymentMethodModel.fromJson(json))
          .toList();

      if (paymentMethods.isNotEmpty) {
        selectedPaymentMethod.value = paymentMethods.first;
      }
    } catch (e) {
      print('Error fetching payment methods: $e');
    }
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSectionHeading(
                  title: 'Select Payment Method', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwSections),
              ...paymentMethods
                  .map((method) => Column(
                        children: [
                          TPaymentTile(paymentMethod: method),
                          const SizedBox(height: TSizes.spaceBtwItems / 2),
                        ],
                      ))
                  .toList(),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  bool isShippingFree(double subTotal) {
    if (settingsController.settings.value.freeShippingThreshold != null &&
        settingsController.settings.value.freeShippingThreshold! > 0.0) {
      if (subTotal > settingsController.settings.value.freeShippingThreshold!) {
        return true;
      }
    }
    return false;
  }

  double getShippingCost(double subTotal) {
    return isShippingFree(subTotal)
        ? 0
        : settingsController.settings.value.shippingCost;
  }

  double getTaxAmount(double subTotal) {
    return settingsController.settings.value.taxRate * subTotal;
  }

  double getTotal(double subTotal) {
    double taxAmount = subTotal * settingsController.settings.value.taxRate;
    double totalPrice = subTotal +
        taxAmount +
        (isShippingFree(subTotal)
            ? 0
            : settingsController.settings.value.shippingCost);
    return double.tryParse(totalPrice.toStringAsFixed(2)) ?? 0.0;
  }
}
