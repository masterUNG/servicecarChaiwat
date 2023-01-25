import 'package:flutter/material.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class WidgetMenu extends StatelessWidget {
  const WidgetMenu({
    Key? key,
    required this.title,
    required this.leadWidget,
    required this.pressFunc,
  }) : super(key: key);

  final String title;
  final Widget leadWidget;
  final Function() pressFunc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadWidget,
      title: WidgetText(
        text: title,
        textStyle: AppConstant().h2Style(),
      ),
      onTap: pressFunc,
    );
  }
}
