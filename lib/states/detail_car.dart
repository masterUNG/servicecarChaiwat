import 'package:flutter/material.dart';
import 'package:tumservicecar/widgets/widget_text.dart';

class DetailCar extends StatelessWidget {
  const DetailCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: WidgetText(text: 'Detail Car'),),);
  }
}