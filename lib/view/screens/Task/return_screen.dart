import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Return_Screen extends StatelessWidget {
  const Return_Screen({super.key});

  @override
  Widget build(BuildContext context) {
  Timer(const Duration(milliseconds: 1000),
        () async => Get.back());
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}