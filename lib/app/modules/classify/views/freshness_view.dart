import 'dart:io';

import 'package:flutter/material.dart';

import 'styles.dart';

class FreshnessView extends StatelessWidget {
  final File? file;
  const FreshnessView({super.key, this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.blueGrey,
      ),
      child: (file == null)
          ? _buildEmptyView()
          : Image.file(file!, fit: BoxFit.cover),
    );
  }

  Widget _buildEmptyView() {
    return const Center(
        child: Text(
      'Please pick a photo',
      style: kAnalyzingTextStyle,
    ));
  }
}
