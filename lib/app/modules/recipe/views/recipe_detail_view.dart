import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RecipeDetailView extends GetView {
  const RecipeDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipeDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RecipeDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
