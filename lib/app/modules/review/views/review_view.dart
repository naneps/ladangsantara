import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReviewView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReviewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
