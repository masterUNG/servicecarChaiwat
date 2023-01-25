import 'package:flutter/material.dart';
import 'package:tumservicecar/utility/app_constant.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true,
        title: WidgetText(
          text: 'Main Home',
          textStyle: AppConstant().h2Style(),
        ),
      ),
    );
  }
}
