import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:noted/models/note_model.dart';
import 'package:noted/views/widgets/loading_indicator.dart';

import '../views/widgets/snack_bar.dart';

class StudyNoteDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late CollectionReference _noteRef;

  Stream get notes => _firestore
      .collection('users')
      .doc(_firebaseAuth.currentUser?.uid)
      .collection('notes')
      .snapshots();

  Future<bool> create(NoteModel note, BuildContext context) async {
    _noteRef = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('study_notes');

    try {
      showLoadingIndicator(context);
      await _noteRef.add({
        'title': note.title,
        'note': note.content,
        'createdAt': DateTime.now(),
      }).then(
        (value) {
          context.pop();
          context.pop();
          showSnackBar(
            context,
            msg: 'New note created',
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
      return Future.error(e.toString());
    }
  }

  Future<bool> update(BuildContext context,
      {required NoteModel note, required String id}) async {
    _noteRef = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('study_notes');

    try {
      showLoadingIndicator(context);
      await _noteRef.doc(id).update({
        'title': note.title,
        'note': note.content,
        'createdAt': DateTime.now(),
      }).then(
        (value) {
          context.pop();
          context.pop();
          showSnackBar(
            context,
            msg: 'Note updated',
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
      return Future.error(e.toString());
    }
  }

  Future<bool> updateArchived(BuildContext context,
      {required NoteModel note, required String id}) async {
    _noteRef = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('archive');

    try {
      showLoadingIndicator(context);
      await _noteRef.doc(id).update({
        'title': note.title,
        'note': note.content,
        'createdAt': DateTime.now(),
      }).then(
        (value) {
          context.pop();
          context.pop();
          showSnackBar(
            context,
            msg: 'Note updated',
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
      return Future.error(e.toString());
    }
  }

  Future<bool> archive(
    BuildContext context, {
    required NoteModel note,
    required String id,
  }) async {
    _noteRef = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('archive');

    try {
      showLoadingIndicator(context);
      await _noteRef.add({
        'title': note.title,
        'note': note.content,
        'createdAt': note.createdAt,
      }).then(
        (value) {
          _firestore
              .collection('users')
              .doc(_firebaseAuth.currentUser?.uid)
              .collection('study_notes')
              .doc(id)
              .delete()
              .then((value) {
            context.pop();
            context.pop();
            showSnackBar(
              context,
              msg: 'Note archived',
            );
          }).catchError((e) {
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
        },
      );
      return true;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> delete(String id, BuildContext context) async {
    _noteRef = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('study_notes');

    try {
      showLoadingIndicator(context);
      await _noteRef.doc(id).delete().then(
        (value) {
          context.pop();
          context.pop();
          showSnackBar(
            context,
            msg: 'Note deleted',
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
      return Future.error(e.toString());
    }
  }

  Future<bool> deleteArchived(String id, BuildContext context) async {
    _noteRef = _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('archive');

    try {
      showLoadingIndicator(context);
      await _noteRef.doc(id).delete().then(
        (value) {
          context.pop();
          context.pop();
          showSnackBar(
            context,
            msg: 'Archived note deleted',
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
      return Future.error(e.toString());
    }
  }
}
