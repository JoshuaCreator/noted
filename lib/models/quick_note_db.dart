import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_firebase/models/note_model.dart';
import 'package:riverpod_firebase/views/widgets/loading_indicator.dart';

import '../views/widgets/snack_bar.dart';

class QuickNoteDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late CollectionReference _taskRef;

  Stream get tasks => _firestore
      .collection('users')
      .doc(_firebaseAuth.currentUser?.uid)
      .collection('tasks')
      .snapshots();

  Future<bool> create(NoteModel task, BuildContext context) async {
    _taskRef = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('quick_notes');

    try {
      showLoadingIndicator(context);
      await _taskRef.add({
        'title': task.title,
        'task': task.content,
        'createdAt': DateTime.now(),
      }).then(
        (value) {
          context.pop();
          context.pop();
          showSnackBar(
            context,
            msg: 'Quick note created',
          );
        },
      ).catchError((e) {
        context.pop();
        showSnackBar(
          context,
          msg: e,
        );
      }).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          context.pop();
          context.pop();
          showSnackBar(
            context,
            msg: 'The connection timed out. Check your internet connection',
          );
        },
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> delete(String id, BuildContext context) async {
    _taskRef = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('quick_notes');

    try {
      showLoadingIndicator(context);
      await _taskRef.doc(id).delete().then(
        (value) {
          context.pop();
          context.pop();
          showSnackBar(
            context,
            msg: 'Quick note deleted',
          );
        },
      ).catchError((e) {
        context.pop();
        showSnackBar(
          context,
          msg: e.toString(),
        );
      }).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          context.pop();
          context.pop();
          showSnackBar(
            context,
            msg: 'The connection timed out. Check your internet connection',
          );
        },
      );
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

}
