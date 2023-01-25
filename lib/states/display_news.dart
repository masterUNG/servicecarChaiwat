import 'package:flutter/material.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class DisplayNews extends StatelessWidget {
  const DisplayNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: 'Display News',
          textStyle: AppConstant().h2Style(),
        ),
      ),
    );
  }
}
