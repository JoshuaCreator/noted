import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:riverpod_firebase/config/consts.dart';
import 'package:riverpod_firebase/config/my_colours.dart';

import '../../providers/theme_provider.dart';

class ThemeSelectorScreen extends ConsumerWidget {
  static String path = 'theme-selector';
  const ThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSelector = ref.watch(themeSelectorProvider.notifier);
    final currentTheme = ref.watch(themeSelectorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Change app theme')),
      body: ListView.separated(
        itemCount: ThemeMode.values.length,
        padding: paddingAll,
        separatorBuilder: (context, index) => height10,
        itemBuilder: (_, index) {
          final themeMode = ThemeMode.values[index];
          return RadioListTile(
            fillColor: MaterialStatePropertyAll(MyColours.white),
            tileColor: MyColours.purple300,
            shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
            value: themeMode,
            groupValue: currentTheme,
            onChanged: (newTheme) => themeSelector.changeAndSave(newTheme!),
            title: Text(
              describeEnum(themeMode).capitalizeFirst!,
              style: TextStyle(color: MyColours.white),
            ),
            subtitle: Text(
              'Use ${themeMode.name} theme',
              style: TextStyle(color: MyColours.purple100),
            ),
          );
        },
      ),
    );
  }
}
