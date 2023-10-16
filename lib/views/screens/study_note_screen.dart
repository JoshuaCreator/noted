import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_firebase/config/consts.dart';
import 'package:riverpod_firebase/models/note_model.dart';
import 'package:riverpod_firebase/providers/firestore_provider.dart';
import 'package:riverpod_firebase/views/screens/note_edit_screen.dart';
import 'package:riverpod_firebase/views/widgets/study_note_tile.dart';

class StudyNoteScreen extends ConsumerWidget {
  static String path = '/study-note';
  const StudyNoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(studyNotesDataProvider);
    return Scaffold(
      body: notes.when(
        data: (data) {
          return data.isEmpty
              ? const Center(child: Text("There aren't any notes here yet"))
              : ListView.builder(
                  padding: EdgeInsets.only(top: ten, bottom: size * 2),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final NoteModel note = NoteModel(
                      id: data[index].id,
                      title: data[index]['title'],
                      content: data[index]['note'],
                      createdAt: (data[index]['createdAt']).toDate(),
                    );
                    return StudyNoteTile(
                      title: note.title,
                      content: note.content,
                      createdAt: note.createdAt!,
                      onTap: () => context.push(
                        '${StudyNoteScreen.path}/${NoteEditScreen.path}',
                        extra: note,
                      ),
                    );
                  },
                );
        },
        error: (error, stackTrace) => const Center(
          child: Center(child: Text('An error occurred')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
