import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_firebase/config/my_colours.dart';

import '../../config/consts.dart';

class QuickNoteTile extends ConsumerWidget {
  const QuickNoteTile({
    super.key,
    required this.title,
    required this.preview,
    required this.createdAt,
    this.onTap,
  });
  final String title, preview;
  final DateTime createdAt;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String formattedDate =
        DateFormat('E dd MMM, yyyy  hh:mm a').format(createdAt);
    return Padding(
      padding: EdgeInsets.only(bottom: ten),
      child: InkWell(
        onTap: onTap,
        borderRadius: defaultBorderRadius,
        child: Container(
          padding: paddingAll,
          decoration: BoxDecoration(
            color: MyColours.purple300,
            borderRadius: defaultBorderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.isEmpty ? '(No title)' : title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: MyColours.white,
                ),
              ),
              height5,
              Text(
                preview,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.0, color: MyColours.white),
              ),
              height5,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formattedDate,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: MyColours.purple100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
