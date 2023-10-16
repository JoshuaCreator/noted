import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted/models/note_model.dart';
import 'package:noted/providers/firestore_provider.dart';
import 'package:noted/views/widgets/quick_note_tile.dart';

import '../../config/consts.dart';
import '../widgets/bottom_sheet/details_widget.dart';

class QuickNoteScreen extends ConsumerWidget {
  static String path = '/quick-note';
  const QuickNoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(quickNotesDataProvider);
    return Scaffold(
      body: tasks.when(
        data: (data) => data.isEmpty
            ? const Center(child: Text("You're all caught up"))
            : ListView.builder(
                padding: EdgeInsets.only(
                  top: ten,
                  bottom: size * 2,
                  left: ten,
                  right: ten,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final NoteModel quickNote = NoteModel(
                    id: data[index].id,
                    title: data[index]['title'],
                    content: data[index]['task'],
                    createdAt: (data[index]['createdAt'] as Timestamp).toDate(),
                  );
                  return QuickNoteTile(
                    title: quickNote.title,
                    preview: quickNote.content,
                    createdAt: quickNote.createdAt!,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => DetailsWidget(
                        title: quickNote.title,
                        content: quickNote.content,
                        id: data[index].id,
                      ),
                    ),
                  );
                },
              ),
        error: (error, stackTrace) => const Center(
          child: Text('An error occurred'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}



// key: const ValueKey(0),
        // startActionPane: ActionPane(
        //   motion: const ScrollMotion(),
          // dismissible: DismissiblePane(
          //   onDismissed: () => TaskDB().delete(id, context),
          // ),
        //   children: [
        //     SlidableAction(
        //       onPressed: (context) => TaskDB().delete(id, context),
        //       backgroundColor: MyColours.purple200,
        //       foregroundColor: Colors.white,
        //       icon: Icons.delete_rounded,
        //       label: 'Delete',
        //     ),
        //   ],
        // ),