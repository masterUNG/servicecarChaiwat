import 'package:flutter/material.dart';

import 'package:tumservicecar/widgets/widget_image.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

import '../utility/app_constant.dart';

class WidgetHead extends StatelessWidget {
  const WidgetHead({
    Key? key,
    this.marginTop,
    this.marginLeft,
  }) : super(key: key);

  final double? marginTop;
  final double? marginLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop ?? 0.0, left: marginLeft ?? 0.0),
      child: Row(
        children: [
          const WidgetImage(
            width: 80,
          ),
          const SizedBox(width: 8,),
          WidgetText(
            text: 'Tum\nservice car',
            textStyle: AppConstant().h2Style(),
          )
        ],
      ),
    );
  }
}
