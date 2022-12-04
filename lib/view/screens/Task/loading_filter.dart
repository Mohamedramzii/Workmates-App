import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:work_os/routes/routes.dart';

class Loading_Screen extends StatelessWidget {
  var page ;
  Loading_Screen({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 1000),
        () async => await Get.toNamed(page));
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
