import 'dart:convert';
import 'dart:io';

import 'package:elue_store/features/shop/models/cart_item_model.dart';
import 'package:elue_store/features/shop/models/cart_item_request.dart';
import 'package:elue_store/features/shop/models/cart_item_response.dart';
import 'package:elue_store/features/shop/models/cart_response.dart';
import 'package:elue_store/features/shop/models/order_request.dart';
import 'package:elue_store/utils/http/http_client.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/order_model.dart';
import '../authentication/authentication_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  /* ---------------------------- FUNCTIONS ---------------------------------*/

  /// Get all order related to current User
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.getUserID;
      if (userId.isEmpty)
        throw 'Unable to find user information. Try again in few minutes.';

      // Sub Collection Order -> Replaced with main Collection
      // final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      final response = await THttpHelper.get('orders?userId=$userId');
      final List<dynamic> orderList = response;
      print("------------------------------------------");
      print((response.toString()));
      return orderList
          .map((orderJson) => OrderModel.fromJson(orderJson))
          .toList();
    } catch (e) {
      print(e);
      throw 'Something went wrong while fetching Order Information. Try again later';
    }
  }

  /// Store new user order
  Future<void> saveOrder(OrderRequest order, String userId,
      [File? paymentReceipt]) async {
    try {
      // final fields = {'order': jsonEncode(order.toJson())};
      if (paymentReceipt != null) {
        final response = await THttpHelper.postWithFile(
            'orders/', order.toJson(), paymentReceipt.path, 'paymentReceipt');

        if (response['OrderStatus'] != 'PENDING') {
          throw 'Failed to save order with payment receipt';
        }
      } else {
        final response = await THttpHelper.post('orders/', order.toJson());

        if (response['OrderStatus'] != 'PENDING') {
          throw 'Failed to save order without payment receipt';
        }
      }
    } catch (e) {
      throw 'Something went wrong while saving Order Information. Try again later';
    }
  }

  Future<dynamic> createCartItem(CartItemModel cartItem) async {
    try {
      CartItemRequest data = CartItemRequest(
        productId: int.parse(cartItem.productId),
        title: cartItem.title,
        price: cartItem.price,
        quantity: cartItem.quantity,
        variationId: cartItem.variationId == "" ? null : cartItem.variationId,
        brandName: cartItem.brandName,
        selectedVariation: cartItem.selectedVariation != null
            ? cartItem.selectedVariation.toString()
            : null,
      );

      final response = await THttpHelper.post('cart-items/', data.toJson());
      CartItemResponse newCartItem = CartItemResponse.fromJson(response);
      print("Cart Item created successfully: $response ${newCartItem.id}");
      return newCartItem.id;
    } catch (e) {
      print("Failed to create cart item: $e");
    }
  }

  Future<dynamic> createCart(List<int> cartItemIds) async {
    print(cartItemIds);
    try {
      final response = await THttpHelper.post('carts/', {"items": cartItemIds});
      // CartResponse cartResp = CartResponse.fromJson(response);
      print("Cart Item created successfully: $response ${response['id']}");
      return response['id'];
    } catch (e) {
      print("Failed to create cart item: $e");
    }
  }
}
