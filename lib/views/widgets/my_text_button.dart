import 'package:flutter/material.dart';
import '../../config/consts.dart';
import '../../config/my_colours.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({super.key, required this.title, this.onTap});
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: MyColours.purple200.withOpacity(0.5),
      highlightColor: MyColours.purple200.withOpacity(0.5),
      borderRadius: defaultBorderRadius,
      onTap: onTap,
      child: Container(
        padding: paddingAll,
        decoration: BoxDecoration(
          borderRadius: defaultBorderRadius,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: MyColours.purple200,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
