import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/widgets/widget_text.dart';
import 'package:tumservicecar/widgets/widget_text_button.dart';

class AppDialog {
  final BuildContext context;
  AppDialog({
    required this.context, 
  });

  void normalDialog({
    required String title,
    String?  subTitle,
    Widget? iconWidget,
    Widget? firstActionWidget,
    Widget? secondActionWidget,
    Widget? contentWidget,
    
  }) {
    Get.dialog(
      AlertDialog(
        icon: iconWidget,
        title: WidgetText(
          text: title,
          textStyle: AppConstant().h2Style(),
        ),
        content:contentWidget ?? WidgetText(
          text: subTitle ?? '',
          textStyle: AppConstant().h3Style(),
        ),
        actions: [
          secondActionWidget ?? const SizedBox(),
          firstActionWidget ??
              WidgetTextButton(
                label: 'Cancel',textColor: Colors.red,
                pressFunc: () {
                  Get.back();
                },
              )
        ],
      ),
    );
  }
}
