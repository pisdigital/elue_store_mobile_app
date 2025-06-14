import 'package:elue_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:elue_store/common/widgets/images/t_rounded_image.dart';
import 'package:elue_store/features/authentication/controllers/store_selection_controller.dart';
import 'package:elue_store/features/shop/models/order_model.dart';
import 'package:elue_store/utils/constants/api_constants.dart';
import 'package:elue_store/utils/constants/colors.dart';
import 'package:elue_store/utils/formatters/formatter.dart';
import 'package:elue_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class OrderDetail extends StatelessWidget {
  final OrderModel order;
  const OrderDetail({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar
      appBar: TAppBar(
          title: Text('Order Detail',
              style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true),
      body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),

          /// -- Orders
          child: Column(
            children: [
              const Text("Order Status"),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: order.status == "PENDING" ||
                              order.status == "CONFIRMED" ||
                              order.status == "DELIVERED"
                          ? Colors.black
                          : Colors.grey,
                    ),
                    child: order.status == "PENDING" ||
                            order.status == "CONFIRMED" ||
                            order.status == "DELIVERED"
                        ? const Icon(
                            Icons.check,
                            size: 14,
                            color: Colors.white,
                          )
                        : Container(),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: const Color(0XFF464A54),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: order.status == "CONFIRMED" ||
                              order.status == "DELIVERED"
                          ? Colors.black
                          : Colors.grey,
                    ),
                    child: order.status == "CONFIRMED" ||
                            order.status == "DELIVERED"
                        ? const Icon(
                            Icons.check,
                            size: 14,
                            color: Colors.white,
                          )
                        : Container(),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: const Color(0XFF464A54),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: order.status == "DELIVERED"
                          ? Colors.black
                          : Colors.grey,
                    ),
                    child: order.status == "DELIVERED"
                        ? const Icon(
                            Icons.check,
                            size: 14,
                            color: Colors.white,
                          )
                        : Container(),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pending',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Confirmed',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Delivered',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const Text("Order Items"),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: order.bigItems.items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(
                                        0x1A000000), // Color with alpha value
                                    blurRadius: 15,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TRoundedImage(
                                  width: 60,
                                  height: 60,
                                  isNetworkImage: true,
                                  imageUrl:
                                      '${TAPIs.serverURL}${order.bigItems.items[index].productId.thumbnail}',
                                  padding: const EdgeInsets.all(TSizes.sm),
                                  backgroundColor: TColors.light,
                                ),
                                Column(
                                  children: [
                                    Text(
                                        '${order.bigItems.items[index].title} (${order.bigItems.items[index].quantity.toString()})'),
                                    Text(
                                      '${order.bigItems.items[index].price.toString()}x${order.bigItems.items[index].quantity.toString()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .apply(
                                              fontWeightDelta: 3,
                                              fontSizeDelta: 3),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const Text("Order Details"),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Order Date"),
                        Text(TFormatter.formatDate(order.orderDate))
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Payment",
                            style: Theme.of(context).textTheme.headlineSmall),
                        Text(
                            '${order.totalAmount.toString()} ${StoreSelectionController.instance.getCurrency()}',
                            style: Theme.of(context).textTheme.headlineSmall)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          )),
    );
  }
}
