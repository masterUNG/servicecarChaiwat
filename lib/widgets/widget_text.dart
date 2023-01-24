import 'package:flutter/material.dart';
import 'package:tumservicecar/utility/app_constant.dart';

class WidgetText extends StatelessWidget {
  const WidgetText({
    Key? key,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle ?? AppConstant().h3Style(),);
  }
}
