import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noted/config/consts.dart';
import 'package:noted/models/auth.dart';
import 'package:noted/views/screens/login_screen.dart';
import 'package:noted/views/widgets/my_button.dart';
import 'package:noted/views/widgets/my_text_button.dart';
import 'package:noted/views/widgets/my_text_field.dart';

class PasswordResetScreen extends StatefulWidget {
  static String path = '/password-reset';
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reset Password'),
      ),
      body: Center(
        child: Padding(
          padding: paddingAll,
          child: Form(
            key: PasswordResetScreen._formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextField(
                  label: 'Email',
                  hintText: 'Enter your email address',
                  controller: emailController,
                ),
                height40,
                MyButton(
                  title: 'Proceed',
                  onTap: () => Auth().sendPasswordResetLink(
                    context,
                    email: emailController.text.trim(),
                  ),
                ),
                height20,
                MyTextButton(
                  title: 'Cancel',
                  onTap: () => context.go(LoginScreen.path),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
