import 'package:flutter/material.dart';
import 'package:noted/config/consts.dart';
import 'package:noted/config/my_colours.dart';

class ReminderTile extends StatefulWidget {
  const ReminderTile({super.key});

  @override
  State<ReminderTile> createState() => _ReminderTileState();
}

class _ReminderTileState extends State<ReminderTile> {
  bool boxChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: paddingAll,
          decoration: BoxDecoration(
            color: MyColours.purple300,
            borderRadius: boxChecked
                ? BorderRadius.only(
                    topLeft: Radius.circular(ten),
                    topRight: Radius.circular(ten),
                  )
                : defaultBorderRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Remind me about this later',
                style: TextStyle(color: MyColours.white),
              ),
              Switch(
                value: boxChecked,
                onChanged: (value) {
                  setState(() {
                    boxChecked = value;
                  });
                },
                inactiveTrackColor: MyColours.purple200,
                inactiveThumbColor: MyColours.main,
                activeColor: MyColours.white,
                trackOutlineColor: MaterialStatePropertyAll(
                  MyColours.purple100,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: boxChecked,
          child: Container(
            padding: paddingAll,
            decoration: BoxDecoration(
              color: MyColours.purple300,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(ten),
                bottomRight: Radius.circular(ten),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Coming soon...😉😁',
                  style: TextStyle(color: MyColours.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
