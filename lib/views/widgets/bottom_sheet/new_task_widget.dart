import 'package:flutter/material.dart';
import 'package:riverpod_firebase/models/quick_note_db.dart';
import 'package:riverpod_firebase/models/note_model.dart';
import 'package:riverpod_firebase/views/widgets/my_button.dart';
import 'package:riverpod_firebase/views/widgets/my_text_field.dart';
import 'package:riverpod_firebase/views/widgets/reminder_tile.dart';

import '../../../config/consts.dart';

class NewTaskWidget extends StatefulWidget {
  const NewTaskWidget({super.key});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<NewTaskWidget> createState() => _NewTaskWidgetState();
}

class _NewTaskWidgetState extends State<NewTaskWidget> {
  String title = '';
  String desc = '';

  @override
  Widget build(BuildContext context) {
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(ten, ten, ten, bottom),
          child: Form(
            key: NewTaskWidget._formKey,
            child: Column(
              children: [
                MyTextField(
                  label: 'Title',
                  hintText: 'What would you like to call it',
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                ),
                height10,
                MyTextField(
                  label: 'Description',
                  hintText: 'Describe what you would like to do',
                  maxLines: 4,
                  onChanged: (value) {
                    setState(() {
                      desc = value;
                    });
                  },
                ),
                height10,
                const ReminderTile(),
                height40,
                MyButton(
                  title: 'Save',
                  onTap: () {
                    if (desc.isEmpty) return;

                    NoteModel task = NoteModel(
                      title: title,
                      content: desc,
                    );
                    QuickNoteDB().create(task, context);
                  },
                ),
                height10,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
