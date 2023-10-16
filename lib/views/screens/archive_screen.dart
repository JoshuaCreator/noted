import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/consts.dart';
import '../../models/note_model.dart';
import '../../providers/firestore_provider.dart';
import '../widgets/study_note_tile.dart';
import 'note_edit_screen.dart';
import 'study_note_screen.dart';

class ArchiveScreen extends ConsumerWidget {
  static String path = 'archive';
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archive = ref.watch(archivedNotesDataProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Archived notes')),
      body: archive.when(
        data: (data) {
          return data.isEmpty
              ? const Center(
                  child: Text("There aren't any archived notes here yet"),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(top: ten, bottom: size * 2),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final NoteModel note = NoteModel(
                      id: data[index].id,
                      title: data[index]['title'],
                      content: data[index]['note'],
                      createdAt: (data[index]['createdAt']).toDate(),
                      archived: true,
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
