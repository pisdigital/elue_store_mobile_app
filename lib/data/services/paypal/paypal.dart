import 'package:elue_store/features/personalization/models/address_model.dart';
import 'package:elue_store/features/shop/models/cart_item_model.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import '../../../utils/constants/api_constants.dart';
import 'dart:async';

class TPaypalService {
  static Future<bool> getPayment(double subTotal, List<CartItemModel> cartItems,
      AddressModel selectedAddress) async {
    final completer = Completer<bool>();

    String subTotalAmount = subTotal.toString();
    await Get.to(() => UsePaypal(
          sandboxMode: false,
          clientId: TAPIs.paypalSandboxClientId,
          secretKey: TAPIs.paypalSandboxSecretKey,
          returnURL: "eluestore://success",
          cancelURL: "eluestore://cancel",
          transactions: [
            {
              "amount": {
                "total": subTotalAmount,
                "currency": "USD",
                "details": {
                  "subtotal": subTotalAmount,
                  "shipping": '0',
                  "shipping_discount": '0'
                }
              },
              "description": "The payment transaction description.",
              // "payment_options": {
              //   "allowed_payment_method":
              //       "INSTANT_FUNDING_SOURCE"
              // },
              "item_list": {
                "items": cartItems
                    .map((item) => {
                          "name": item.productId.toString(),
                          "quantity": item.quantity,
                          "price": (item.price).toStringAsFixed(2).toString(),
                          "currency": "USD"
                        })
                    .toList(),

                // shipping address is not required though
                "shipping_address": {
                  "recipient_name": "${selectedAddress.name}",
                  "line1": "${selectedAddress.street}",
                  // "line2": "${selectedAddress.extraDetails}",
                  "city": "${selectedAddress.city}",
                  "country_code": "US",
                  "postal_code": "${selectedAddress.postalCode}",
                  "phone": "${selectedAddress.phoneNumber}",
                  "state": "${selectedAddress.state}"
                },
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) {
            print("onSuccess: $params");
            Get.back();
            completer.complete(true);
          },
          onError: (error) {
            print("onError: $error");
            Get.back();
            completer.complete(false);
          },
          onCancel: (params) {
            print('cancelled: $params');
            Get.back();
            completer.complete(false);
          },
        ));

    final success = await completer.future;
    print("PAYPAL RESULT: $success");
    return success;
  }
}
