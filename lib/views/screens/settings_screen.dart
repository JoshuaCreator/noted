import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_firebase/config/consts.dart';
import 'package:riverpod_firebase/views/screens/login_screen.dart';
import 'package:riverpod_firebase/views/screens/theme_selector_screen.dart';
import 'package:riverpod_firebase/views/widgets/settings_tile.dart';

import '../../models/auth.dart';
import 'archive_screen.dart';

class SettingsScreen extends StatelessWidget {
  static String path = '/settings';
  SettingsScreen({super.key});

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            onPressed: () {
              Auth().signOut(context);
              context.go(LoginScreen.path);
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: paddingAll,
        children: [
          SettingsTile(
            onTap: () => context.push(
              '${SettingsScreen.path}/${ThemeSelectorScreen.path}',
            ),
            title: 'Theme setting',
            subTitle: 'Change app theme',
            icon: Icons.light_mode_rounded,
          ),
          SettingsTile(
            onTap: () => context.push(
              '${SettingsScreen.path}/${ArchiveScreen.path}',
            ),
            title: 'Archived notes',
            subTitle: 'Find all your archived notes here',
            icon: Icons.archive_rounded,
          ),
          SettingsTile(
            showTrailing: false,
            title: 'Email address',
            subTitle: auth.currentUser!.email!,
            icon: Icons.account_circle_rounded,
          ),
        ],
      ),
    );
  }
}
