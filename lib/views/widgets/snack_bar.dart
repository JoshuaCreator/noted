import 'package:flutter/material.dart';
import 'package:noted/config/consts.dart';
import 'package:noted/config/my_colours.dart';

showSnackBar(BuildContext context, {required String msg}) {
  final SnackBar snackBar = SnackBar(
    content: Text(
      msg,
      textAlign: TextAlign.center,
      style: TextStyle(color: MyColours.white),
    ),
    shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    backgroundColor: MyColours.purple200,
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
