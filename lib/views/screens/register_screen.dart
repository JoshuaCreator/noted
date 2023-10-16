import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_firebase/config/consts.dart';
import 'package:riverpod_firebase/models/auth.dart';
import 'package:riverpod_firebase/views/screens/login_screen.dart';
import 'package:riverpod_firebase/views/widgets/my_button.dart';
import 'package:riverpod_firebase/views/widgets/my_text_button.dart';
import 'package:riverpod_firebase/views/widgets/my_text_field.dart';

import '../../config/my_colours.dart';

class RegisterScreeen extends StatefulWidget {
  static String path = '/register';
  const RegisterScreeen({super.key});

  @override
  State<RegisterScreeen> createState() => _RegisterScreeenState();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
}

class _RegisterScreeenState extends State<RegisterScreeen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: paddingAll,
          child: Form(
            key: RegisterScreeen._formKey,
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
                height40,
                MyButton(
                  title: 'Register',
                  onTap: () => Auth().register(
                    context,
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                ),
                height20,
                MyTextButton(
                  title: 'Login',
                  onTap: () => context.go(LoginScreen.path),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
