import 'package:flutter/material.dart';

class WidgetImageNetwork extends StatelessWidget {
  const WidgetImageNetwork({
    Key? key,
    required this.urlImage,
    this.size,
    this.boxFit,
  }) : super(key: key);

  final String urlImage;
  final double? size;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      urlImage,
      width: size,
      height: size,
      fit: boxFit,
    );
  }
}
