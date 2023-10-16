import 'package:flutter/material.dart';
import 'package:riverpod_firebase/config/my_colours.dart';

import '../../config/consts.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.suffixIcon,
    this.obscureText = false,
  });
  final String label;
  final String hintText;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? initialValue;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: defaultBorderRadius),
        label: Text(label),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: defaultBorderRadius,
          borderSide: BorderSide(
            color: MyColours.purple300,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: defaultBorderRadius,
          borderSide: BorderSide(
            color: MyColours.purple300,
          ),
        ),
      ),
      maxLines: maxLines,
      minLines: minLines,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      textInputAction: textInputAction,
      initialValue: initialValue,
    );
  }
}
