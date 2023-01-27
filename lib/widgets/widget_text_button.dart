import 'package:flutter/material.dart';

import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class WidgetTextButton extends StatelessWidget {
  const WidgetTextButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.textColor,
    this.size,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final Color? textColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: pressFunc,
      child: WidgetText(
        text: label,
        textStyle: AppConstant().h3Style(
            color: textColor ?? Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            size: size),
      ),
    );
  }
}
