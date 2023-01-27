import 'package:flutter/material.dart';

import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.width,
    this.bgColor,
    this.textColor,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final double? width;
  final Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: pressFunc,
        child: WidgetText(text: label,textStyle: AppConstant().h3Style(color: textColor),),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: AppConstant.dark)),
        ),
      ),
    );
  }
}
