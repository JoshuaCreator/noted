import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/consts.dart';
import '../../config/my_colours.dart';

class StudyNoteTile extends StatelessWidget {
  const StudyNoteTile({
    super.key,
    required this.title,
    required this.content,
    required this.createdAt,
    this.onTap,
  });
  final String title;
  final String content;
  final DateTime createdAt;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('E dd MMM, yyyy  hh:mm a').format(createdAt);
    return Padding(
      padding: EdgeInsets.fromLTRB(ten, 0.0, ten, ten),
      child: InkWell(
        onTap: onTap,
        borderRadius: defaultBorderRadius,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ten),
              decoration: BoxDecoration(
                color: MyColours.purple200.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ten),
                  topRight: Radius.circular(ten),
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16.0,
                  color: MyColours.white,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ten),
              decoration: BoxDecoration(
                color: MyColours.purple300.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(ten),
                  bottomRight: Radius.circular(ten),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: MyColours.white,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  height10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: MyColours.purple100,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
