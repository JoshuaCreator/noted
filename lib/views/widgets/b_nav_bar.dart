import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noted/config/consts.dart';
import 'package:noted/config/my_colours.dart';
import 'package:noted/views/screens/settings_screen.dart';
import 'package:noted/views/screens/quick_note_screen.dart';
import 'package:noted/views/screens/study_note_screen.dart';
import 'fab.dart';

class BNavBar extends ConsumerStatefulWidget {
  static String path = '/';
  const BNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BNavBarState();
}

class _BNavBarState extends ConsumerState<BNavBar> {
  int currentPageIndex = 0;
  List<String> appBarTitle = [
    'QUICK NOTES',
    'STUDY NOTES',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(appBarTitle[currentPageIndex]),
      extendBody: true,
      body: <Widget>[
        const QuickNoteScreen(),
        const StudyNoteScreen(),
      ][currentPageIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(ten, 0.0, ten, ten),
        child: ClipRRect(
          borderRadius: defaultBorderRadius,
          child: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: size * 2,
            backgroundColor: MyColours.purple300,
            indicatorColor: MyColours.purple300,
            elevation: 0,
            selectedIndex: currentPageIndex,
            destinations: <Widget>[
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.task_rounded,
                  color: MyColours.white,
                ),
                icon: Icon(
                  Icons.task_outlined,
                  color: MyColours.purple100,
                ),
                label: 'Tasks',
                tooltip: 'Tasks',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.note_rounded,
                  color: MyColours.white,
                ),
                icon: Icon(
                  Icons.note_outlined,
                  color: MyColours.purple100,
                ),
                label: 'Notes',
                tooltip: 'Notes',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MyFAB(currentPageIndex: currentPageIndex),
    );
  }

  AppBar buildAppBar(String title) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          tooltip: 'Settings',
          onPressed: () => context.push(SettingsScreen.path),
          icon: const Icon(Icons.settings_rounded),
        ),
      ],
      backgroundColor: Colors.transparent,
      surfaceTintColor: MyColours.purple100,
    );
  }
}
