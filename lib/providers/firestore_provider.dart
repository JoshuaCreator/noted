import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_provider.dart';

// ⭐⭐ RETRIEVE DATA FROM FIRESTORE USING RIVERPOD ⭐⭐

//? *************** Get QuickNotes ***************//
final quickNotesDataProvider = StreamProvider.autoDispose(
  (ref) {
    final userStream = ref.watch(authStateProvider);
    final firestore = ref.watch(firestoreProvider);

    var user = userStream.value;

    var docRef = firestore
        .collection('users')
        .doc(user?.uid)
        .collection('quick_notes')
        .orderBy('createdAt', descending: true);
    return docRef.snapshots().map((doc) => doc.docs);
  },
);

//? *************** Get StudyNotes ***************//
final studyNotesDataProvider = StreamProvider.autoDispose(
  (ref) {
    final userStream = ref.watch(authStateProvider);
    final firestore = ref.watch(firestoreProvider);

    var user = userStream.value;

    var docRef = firestore
        .collection('users')
        .doc(user?.uid)
        .collection('study_notes')
        .orderBy('createdAt', descending: true);
    return docRef.snapshots().map((doc) => doc.docs);
  },
);

//? *************** Get Archived Notes ***************//
final archivedNotesDataProvider = StreamProvider.autoDispose(
  (ref) {
    final userStream = ref.watch(authStateProvider);
    final firestore = ref.watch(firestoreProvider);

    var user = userStream.value;

    var docRef = firestore
        .collection('users')
        .doc(user?.uid)
        .collection('archive')
        .orderBy('createdAt', descending: true);
    return docRef.snapshots().map((doc) => doc.docs);
  },
);

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});
