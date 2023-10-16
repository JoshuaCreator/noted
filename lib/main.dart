import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firebase/providers/theme_provider.dart';
import 'package:riverpod_firebase/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/sizes.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);
    Sizes().init(context);
    return user.when(
      data: (data) => MaterialApp.router(
        title: 'Awesome App',
        debugShowCheckedModeBanner: false,
        themeMode: ref.watch(themeSelectorProvider),
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        routerConfig: goRouter,
      ),
      error: (error, stackTrace) => const Center(
        child: Text('An error occurred'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
