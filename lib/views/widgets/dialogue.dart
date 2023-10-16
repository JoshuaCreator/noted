import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_firebase/config/consts.dart';
import 'package:riverpod_firebase/views/widgets/my_text_button.dart';

Future<bool?> showDialogue(
  BuildContext context, {
  required String title,
  required String content,
  String? proceedTxt,
  String? cancelTxt,
  bool barrierDismissable = false,
  required void Function()? onProceed,
  void Function()? onDismiss,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissable,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: defaultBorderRadius,
        ),
        title: Text(title),
        content: Text(content),
        actions: [
          MyTextButton(
            title: cancelTxt ?? 'Dismiss',
            onTap: onDismiss ?? () => context.pop(),
          ),
          MyTextButton(
            title: proceedTxt ?? 'Proceed',
            onTap: onProceed,
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
      );
    },
  );
}
