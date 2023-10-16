import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noted/models/quick_note_db.dart';
import 'package:noted/views/widgets/dialogue.dart';
import 'package:share_plus/share_plus.dart';

import '../../../config/consts.dart';
import '../../../config/my_colours.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    super.key,
    required this.title,
    required this.content,
    required this.id,
  });
  final String title, content, id;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: paddingAll,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: MyColours.purple50,
              borderRadius: defaultBorderRadius,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: MyColours.purple300,
              ),
            ),
          ),
          height10,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: MyColours.purple50,
              borderRadius: defaultBorderRadius,
            ),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16.0,
                color: MyColours.purple300,
              ),
            ),
          ),
          height40,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                tooltip: 'Share note',
                onPressed: () => showDialogue(
                  context,
                  title: 'Share note',
                  content: 'Share this note with the title?',
                  proceedTxt: 'Yes',
                  cancelTxt: 'No',
                  barrierDismissable: true,
                  onProceed: () {
                    context.pop();
                    Share.share('$title\n\n$content');
                  },
                  onDismiss: () {
                    context.pop();
                    Share.share(content);
                  },
                ),
                icon: const Icon(Icons.share_rounded),
              ),
              IconButton(
                tooltip: 'Delete note',
                onPressed: () => showDialogue(
                  context,
                  title: 'Delete quick note',
                  content:
                      'Do you want to delete this note? This cannot be undone.',
                  proceedTxt: 'Delete',
                  onProceed: () {
                    context.pop();
                    QuickNoteDB().delete(id, context);
                  },
                ),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
