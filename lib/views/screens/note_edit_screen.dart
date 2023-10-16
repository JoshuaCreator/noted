import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_firebase/config/consts.dart';
import 'package:riverpod_firebase/models/study_note_db.dart';
import 'package:riverpod_firebase/models/note_model.dart';
import 'package:riverpod_firebase/views/widgets/my_button.dart';
import 'package:riverpod_firebase/views/widgets/my_text_field.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/dialogue.dart';

class NoteEditScreen extends StatefulWidget {
  static String path = 'edit';
  const NoteEditScreen({
    super.key,
    this.appBarTitle,
    this.newNote = false,
    this.showQuickActions = true,
    this.note,
  });
  final String? appBarTitle;
  final bool newNote, showQuickActions;
  final NoteModel? note;

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  String? title;
  String? noteTxt;
  late NoteModel note;

  @override
  void initState() {
    title = widget.note?.title ?? '';
    noteTxt = widget.note?.content ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    note = NoteModel(
      title: title!,
      content: noteTxt!,
    );
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.appBarTitle ?? 'Edit Note')),
        body: SingleChildScrollView(
          padding: paddingAll,
          child: Column(
            children: [
              MyTextField(
                label: 'Title',
                hintText: 'Name your note',
                textInputAction: TextInputAction.next,
                initialValue: widget.note?.title,
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              height10,
              MyTextField(
                label: 'Note',
                hintText: 'Start typing stuff...',
                minLines: 10,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                initialValue: widget.note?.content,
                onChanged: (value) {
                  setState(() {
                    noteTxt = value;
                  });
                },
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          Column(
            children: [
              StudyNoteEditQuickActions(
                showQuickActions: widget.showQuickActions,
                id: widget.note?.id,
                title: widget.note?.title,
                content: widget.note?.content,
                createdAt: widget.note?.createdAt,
                archived: widget.note?.archived ?? widget.showQuickActions,
              ),
              height20,
              MyButton(
                title: widget.newNote ? 'Create' : 'Update',
                onTap: () {
                  if (title!.isEmpty || noteTxt!.isEmpty) return;

                  widget.newNote
                      ? StudyNoteDB().create(note, context)
                      : widget.note!.archived!
                          ? StudyNoteDB().updateArchived(
                              context,
                              note: note,
                              id: widget.note!.id!,
                            )
                          : StudyNoteDB().update(
                              context,
                              note: note,
                              id: widget.note!.id!,
                            );
                },
              ),
              height10,
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> onWillPop() async {
    bool isEdited =
        title != widget.note?.title || noteTxt != widget.note?.content;
    if (widget.newNote && (title!.isEmpty && noteTxt!.isEmpty)) {
      return true;
    }
    if (isEdited) {
      final result = await showDialogue(
        context,
        title: 'Save changes',
        content: 'Save before exiting?',
        proceedTxt: 'Save',
        cancelTxt: "Don't save",
        barrierDismissable: true,
        onProceed: () {
          context.pop();
          StudyNoteDB().update(
            context,
            note: note,
            id: widget.note!.id!,
          );
        },
        onDismiss: () {
          context.pop();
          context.pop();
        },
      );
      return result ?? false;
    } else {
      return true;
    }
  }
}

class StudyNoteEditQuickActions extends StatelessWidget {
  const StudyNoteEditQuickActions({
    super.key,
    required this.showQuickActions,
    required this.archived,
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  final bool showQuickActions, archived;
  final String? id, title, content;
  final DateTime? createdAt;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showQuickActions,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            tooltip: 'Delete study note',
            onPressed: () => showDialogue(
              context,
              title: 'Delete note',
              proceedTxt: 'Delete',
              content:
                  'Do you want to delete this note? This cannot be undone.',
              onProceed: () {
                context.pop();
                archived
                    ? StudyNoteDB().deleteArchived(id!, context)
                    : StudyNoteDB().delete(id!, context);
              },
            ),
            icon: const Icon(Icons.delete_rounded),
          ),
          height10,
          Visibility(
            visible: !archived,
            child: IconButton(
              tooltip: 'Archive study note',
              onPressed: () => showDialogue(
                context,
                title: 'Archive note',
                content: 'Do you want to archive this note?',
                proceedTxt: 'Archive',
                onProceed: () {
                  final NoteModel note = NoteModel(
                    id: id!,
                    title: title!,
                    content: content!,
                    createdAt: createdAt,
                  );
                  context.pop();
                  StudyNoteDB().archive(context, note: note, id: note.id!);
                },
              ),
              icon: const Icon(Icons.archive_rounded),
            ),
          ),
          height10,
          IconButton(
            tooltip: 'Share study note',
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
                Share.share('$content');
              },
            ),
            icon: const Icon(Icons.share_rounded),
          ),
        ],
      ),
    );
  }
}
