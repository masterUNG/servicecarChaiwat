import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class AppSnackBar {
  void normalSnackbar({
    required String title,
    required String message,
    Color? bgColor,
    Color? textColor,
    SnackPosition? snackPosition,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: bgColor,
      snackPosition: snackPosition ?? SnackPosition.BOTTOM,
      colorText: textColor,
    );
  }
}
