import 'package:flutter/material.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class ProcessAddCar extends StatelessWidget {
  const ProcessAddCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          text: 'เพิ่มจำนวนรถ ที่จะบันทึก',
          textStyle: AppConstant().h2Style(),
        ),
      ),
    );
  }
}
