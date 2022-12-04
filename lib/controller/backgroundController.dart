import 'package:flutter/animation.dart';
import 'package:get/state_manager.dart';

class AnimationBackground_Controller extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));

    animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            update();
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
              update();
            }
          });
    _animationController.forward();
    update();
    super.onInit();
  }
}
