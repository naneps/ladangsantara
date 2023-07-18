import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_address_controller.dart';

class OrderAddressView extends GetView<OrderAddressController> {
  const OrderAddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderAddressView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OrderAddressView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
