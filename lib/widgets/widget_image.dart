import 'package:flutter/material.dart';

class WidgetImage extends StatelessWidget {
  const WidgetImage({
    Key? key,
    this.width,
    this.path,
  }) : super(key: key);

  final double? width;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path ?? 'images/logo.png',
      width: width,
    );
  }
}
