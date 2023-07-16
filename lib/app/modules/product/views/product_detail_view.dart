import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProductDetailView extends GetView {
  const ProductDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProductDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
