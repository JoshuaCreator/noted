import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted/providers/auth_provider.dart';
import 'package:noted/views/screens/login_screen.dart';
import 'package:noted/views/screens/verify_email_screen.dart';
import 'package:noted/views/widgets/b_nav_bar.dart';

class AuthChecker extends ConsumerWidget {
  static String path = '/auth-checker';
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) {
        if (data != null && data.emailVerified) {
          return const BNavBar();
        } else if (data != null && !data.emailVerified) {
          return const VerifyEmailScreen();
        }
        return const LoginScreen();
      },
      error: (error, stackTrace) => const Center(
        child: Text('An error occurred'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
