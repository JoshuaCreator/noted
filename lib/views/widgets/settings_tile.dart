import 'package:flutter/material.dart';
import 'package:riverpod_firebase/config/consts.dart';
import 'package:riverpod_firebase/config/my_colours.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    required this.subTitle,
    this.showTrailing = true,
    this.onTap,
    required this.icon,
  });
  final String title, subTitle;
  final bool showTrailing;
  final void Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: paddingOnlyTop,
      decoration: BoxDecoration(
        color: MyColours.purple300,
        borderRadius: defaultBorderRadius,
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(color: MyColours.white),
        ),
        subtitle: Text(
          subTitle,
          style: TextStyle(color: MyColours.purple100),
        ),
        leading: Icon(icon, color: MyColours.white),
        trailing: showTrailing
            ? Icon(
                Icons.keyboard_arrow_right_rounded,
                color: MyColours.white,
              )
            : null,
        shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      ),
    );
  }
}
