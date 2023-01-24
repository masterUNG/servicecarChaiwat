import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class AppSnackBar {
  void narmalSnackbar(
      {required String title, required String message, Color? bgColor}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: bgColor,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
