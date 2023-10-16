import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_firebase/config/consts.dart';
import 'package:riverpod_firebase/config/my_colours.dart';
import 'package:riverpod_firebase/models/auth.dart';
import 'package:riverpod_firebase/views/screens/password_reset_screen.dart';
import 'package:riverpod_firebase/views/widgets/my_button.dart';
import 'package:riverpod_firebase/views/widgets/my_text_button.dart';
import 'package:riverpod_firebase/views/widgets/my_text_field.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  static String path = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: paddingAll,
          child: Form(
            key: LoginScreen._formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextField(
                  label: 'Email',
                  hintText: 'Enter your email address',
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                ),
                height20,
                MyTextField(
                  label: 'Password',
                  hintText: 'Enter your password',
                  controller: passwordController,
                  obscureText: obscureText,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      obscureText = !obscureText;
                    }),
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                    ),
                    color: MyColours.purple300,
                  ),
                ),
                height5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => context.go(
                        PasswordResetScreen.path,
                      ),
                      child: const Text(
                        'Reset password',
                      ),
                    ),
                  ],
                ),
                height5,
                MyButton(
                  title: 'Log In',
                  onTap: () => Auth().logIn(
                    context,
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                ),
                height20,
                MyTextButton(
                  title: 'Register',
                  onTap: () => context.go(RegisterScreeen.path),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
