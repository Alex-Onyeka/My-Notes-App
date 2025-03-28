import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/class/note_class.dart';
import 'package:mynotes/class/user_class.dart';
import 'package:mynotes/services/auth_services.dart';

class FireStoreService {
  //
  //
  AuthServices authServices = AuthServices();

  CollectionReference<Map<String, dynamic>> userDb =
      FirebaseFirestore.instance.collection('users');

  CollectionReference<Map<String, dynamic>> noteDb =
      FirebaseFirestore.instance.collection('notes');

  //
  //
  // Get Current User
  Future<DocumentSnapshot<Map<String, dynamic>>?>
  getCurrentUserDoc() async {
    var firstStep =
        await userDb
            .where(
              'uid',
              isEqualTo:
                  authServices.currentLoggedInUser().uid,
            )
            .get();

    if (firstStep.docs.isNotEmpty) {
      return firstStep.docs.first;
    } else {
      return null;
    }
  }

  //
  //
  // Get Current User
  Future<DocumentSnapshot<Map<String, dynamic>>?>
  getNavigatedUserDoc(String uid) async {
    var firstStep =
        await userDb.where('uid', isEqualTo: uid).get();

    if (firstStep.docs.isNotEmpty) {
      return firstStep.docs.first; // Return first document
    } else {
      return null; // Return null if no document is found
    }
  }

  //
  //
  // Get Current User Stream
  // Stream to get the current user's document in real-time
  Stream<DocumentSnapshot<Map<String, dynamic>>?>
  getCurrentUserDocStream() {
    return userDb
        .where(
          'uid',
          isEqualTo: authServices.currentLoggedInUser().uid,
        )
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.isNotEmpty
                  ? snapshot.docs.first
                  : null,
        );
  }

  // Create Note
  void createNote(NoteClass note) async {
    DocumentReference docRef = noteDb.doc();
    await docRef.set({
      'noteId': docRef.id,
      'title': note.title,
      'note': note.note,
      'createdTime': Timestamp.now(),
      'user': note.user.uid,
      'author': note.user.displayName,
      'noteM': [
        {
          'text': note.noteM[0].text,
          'type': note.noteM[0].type,
          'time': Timestamp.now(),
        },
      ],
    });
  }

  // Get All Notes Except Logged User's Notes
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  getNotesExceptLoddedInUsersNotes(User user) {
    return noteDb
        .where('user', isNotEqualTo: user.uid)
        .orderBy('createdTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  // Get Only LoggedInUsers note
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  getUsersNotes(String uid) {
    return noteDb
        .where('user', isEqualTo: uid)
        .orderBy('createdTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  //
  //
  // Create User Document
  void createUserDoc(
    User authUser,
    UserClass user,
    BuildContext context,
  ) async {
    await userDb.add({
      'name': user.name,
      'email': user.email,
      'gender': user.gender,
      'uid': user.uid,
      'createdTime': Timestamp.now(),
    });

    // Show SnackBar
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          style: TextStyle(color: Colors.white),
          '${user.name} added Successfully',
        ),
      ),
    );
  }

  //
  //
  //
  //
  //
  //
  Stream<List<DocumentSnapshot>> getFavoriteNotesStream(
    List<String> noteIds,
  ) {
    if (noteIds.isEmpty) {
      return Stream.value([]);
    }

    return FirebaseFirestore.instance
        .collection('your_collection_name')
        .where(FieldPath.documentId, whereIn: noteIds)
        .snapshots() // <-- This listens for real-time updates!
        .map((snapshot) => snapshot.docs);
  }
}
