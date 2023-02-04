import 'package:flutter/material.dart';

import 'package:tumservicecar/utility/app_constant.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    required this.hint,
    required this.changeFunc,
    this.width,
    this.obsecu,
    this.subfixWidget,
    this.textInputType,
    this.textEditingController,
  }) : super(key: key);

  final String hint;
  final Function(String) changeFunc;
  final double? width;
  final bool? obsecu;
  final Widget? subfixWidget;
  final TextInputType? textInputType;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: width ?? 250,
      height: 40,
      child: TextFormField(
        controller: textEditingController,
        style: AppConstant().h3Style(),
        keyboardType: textInputType,
        obscureText: obsecu ?? false,
        onChanged: changeFunc,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.5),
          suffixIcon: subfixWidget,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          filled: true,
          hintText: hint,
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder() =>
      OutlineInputBorder(borderRadius: BorderRadius.circular(15));
}
