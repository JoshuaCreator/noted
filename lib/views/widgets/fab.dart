import 'package:flutter/material.dart';
import 'package:riverpod_firebase/views/screens/note_edit_screen.dart';

import 'bottom_sheet/new_task_widget.dart';

class MyFAB extends StatelessWidget {
  const MyFAB({super.key, required this.currentPageIndex});
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: currentPageIndex == 0
          ? () => showModalBottomSheet(
                context: context,
                useSafeArea: true,
                isScrollControlled: true,
                builder: (context) => const NewTaskWidget(),
              )
          : currentPageIndex == 1
              ? () => showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    isScrollControlled: true,
                    isDismissible: false,
                    builder: (context) => const NoteEditScreen(
                      appBarTitle: 'New Note',
                      newNote: true,
                      showQuickActions: false,
                    ),
                  )
              : () => const SizedBox(),
      child: const Icon(
        Icons.add_rounded,
      ),
    );
  }
}
