import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted/config/my_colours.dart';

import '../../config/consts.dart';

class MyButton extends ConsumerWidget {
  const MyButton({super.key, required this.title, this.onTap});
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      splashColor: MyColours.purple50.withOpacity(0.5),
      highlightColor: MyColours.purple50.withOpacity(0.5),
      borderRadius: defaultBorderRadius,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: defaultBorderRadius,
          color: MyColours.main.withOpacity(0.5),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: MyColours.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
