import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noted/config/consts.dart';
import 'package:noted/models/auth.dart';
import 'package:noted/views/widgets/b_nav_bar.dart';
import 'package:noted/views/widgets/my_text_button.dart';

class VerifyEmailScreen extends StatefulWidget {
  static String path = '/verify-email';
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final auth = FirebaseAuth.instance;
  late Timer timer;
  @override
  void initState() {
    if (!auth.currentUser!.emailVerified) {
      Auth().sendEmailVerificationLink(context);
    }
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        setState(() {
          auth.currentUser?.reload();
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'A verification email has been sent to you at ${auth.currentUser?.email}',
            textAlign: TextAlign.center,
          ),
          Visibility(
            visible: auth.currentUser!.emailVerified,
            child: Column(
              children: [
                height30,
                MyTextButton(
                  title: 'Verified',
                  onTap: () {
                    if (auth.currentUser!.emailVerified) {
                      context.go(BNavBar.path);
                    } else {
                      return;
                    }
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible: !auth.currentUser!.emailVerified,
            child: Column(
              children: [
                height30,
                MyTextButton(
                  title: 'Cancel',
                  onTap: () => Auth().signOut(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
