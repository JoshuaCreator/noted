import 'package:flutter/material.dart';

import '../config/consts.dart';
import '../config/my_colours.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    iconTheme: IconThemeData(color: MyColours.main),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll<Color>(MyColours.main),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: MyColours.white,
      backgroundColor: MyColours.purple100,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      surfaceTintColor: null,
      backgroundColor: Colors.transparent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll<Color?>(
          MyColours.white.withOpacity(0.5),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          ),
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      modalElevation: 1,
      shape: BeveledRectangleBorder(),
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.transparent,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: MyColours.main),
    colorScheme: const ColorScheme.light(),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    iconTheme: IconThemeData(color: MyColours.purple50),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll<Color>(MyColours.purple50),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: MyColours.white,
      backgroundColor: MyColours.purple100,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      surfaceTintColor: null,
      backgroundColor: Colors.transparent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll<Color?>(
          MyColours.purple100.withOpacity(0.5),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          ),
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      modalElevation: 1,
      shape: BeveledRectangleBorder(),
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.transparent,
    ),
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: MyColours.purple50),
    colorScheme: const ColorScheme.dark(),
    useMaterial3: true,
  );
}
