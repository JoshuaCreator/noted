import 'package:go_router/go_router.dart';
import 'package:noted/models/note_model.dart';
import 'package:noted/views/screens/archive_screen.dart';
import 'package:noted/views/screens/auth_checker.dart';
import 'package:noted/views/screens/settings_screen.dart';
import 'package:noted/views/screens/quick_note_screen.dart';
import 'package:noted/views/screens/login_screen.dart';
import 'package:noted/views/screens/note_edit_screen.dart';
import 'package:noted/views/screens/study_note_screen.dart';
import 'package:noted/views/screens/password_reset_screen.dart';
import 'package:noted/views/screens/register_screen.dart';
import 'package:noted/views/screens/theme_selector_screen.dart';
import 'package:noted/views/screens/verify_email_screen.dart';
import 'package:noted/views/widgets/b_nav_bar.dart';

GoRouter goRouter = GoRouter(
  initialLocation: AuthChecker.path,
  routes: [
    GoRoute(
      path: AuthChecker.path,
      builder: (context, state) => const AuthChecker(),
    ),
    GoRoute(
      path: VerifyEmailScreen.path,
      builder: (context, state) => const VerifyEmailScreen(),
    ),
    GoRoute(
      path: BNavBar.path,
      builder: (context, state) => const BNavBar(),
    ),
    GoRoute(
      path: QuickNoteScreen.path,
      builder: (context, state) => const QuickNoteScreen(),
    ),
    GoRoute(
      path: LoginScreen.path,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RegisterScreeen.path,
      builder: (context, state) => const RegisterScreeen(),
    ),
    GoRoute(
      path: PasswordResetScreen.path,
      builder: (context, state) => const PasswordResetScreen(),
    ),
    GoRoute(
      path: StudyNoteScreen.path,
      builder: (context, state) => const StudyNoteScreen(),
      routes: [
        GoRoute(
          path: NoteEditScreen.path,
          builder: (context, state) {
            NoteModel noteModel = state.extra as NoteModel;
            return NoteEditScreen(
              note: noteModel,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: SettingsScreen.path,
      builder: (context, state) => SettingsScreen(),
      routes: [
        GoRoute(
          path: ThemeSelectorScreen.path,
          builder: (context, state) => const ThemeSelectorScreen(),
        ),
        GoRoute(
          path: ArchiveScreen.path,
          builder: (context, state) => const ArchiveScreen(),
        ),
      ],
    ),
  ],
);
