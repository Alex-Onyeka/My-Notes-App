import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/authentication/login_page.dart';
import 'package:mynotes/components/alert_info.dart';
import 'package:mynotes/pages/home.dart';
import 'package:mynotes/provider/main_provider.dart';
import 'package:provider/provider.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>>
  firebaseFirestore = FirebaseFirestore.instance.collection(
    'users',
  );
  //
  //

  // Get current Logged in User
  User currentLoggedInUser() {
    return FirebaseAuth.instance.currentUser!;
  }

  // Get current Logged in User
  User getUserWithUid(String uid) {
    return FirebaseAuth.instance.currentUser!;
  }

  // Create User With Email and Password
  Future createUserAccount({
    required String email,
    required String password,
    required String confirmPassword,
    required String userName,
    required String gender,
    required BuildContext context,
  }) async {
    try {
      if (email.isEmpty ||
          password.isEmpty ||
          userName.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertInfo(
              title: 'Missing Fields!',
              message:
                  'All Fields Must be filled/selected before Proceeding. ',
            );
          },
        );
      } else if (password != confirmPassword) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertInfo(
              title: 'Password Mismatch!',
              message:
                  'Your passwords are not the same. Make corrections and try again.',
            );
          },
        );
      } else {
        context.read<MainProvider>().startLoading();
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            );

        await currentLoggedInUser().updateDisplayName(
          userName,
        );

        User? newUser = userCredential.user;
        if (newUser != null) {
          await firebaseFirestore.doc(newUser.uid).set({
            'name': userName,
            'email': newUser.email,
            'gender': gender,
            'uid': newUser.uid,
            'createdDate': Timestamp.now(),
          });
        }

        if (!context.mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        context.read<MainProvider>().stopLoading();
      }
    } on FirebaseException catch (e) {
      context.read<MainProvider>().stopLoading();
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return AlertInfo(
            title: 'Error Occurred',
            message: e.code,
          );
        },
      );
      context.read<MainProvider>().stopLoading();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  //
  //
  // Login With Email and Password
  Future loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertInfo(
            title: 'Missing Fields!',
            message:
                'All Fields Must be filled/selected before Proceeding. ',
          );
        },
      );
      return;
    }
    try {
      context.read<MainProvider>().startLoading();
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseException catch (e) {
      context.read<MainProvider>().stopLoading();
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return AlertInfo(
            title: 'Error Occurred',
            message: e.code,
          );
        },
      );
      context.read<MainProvider>().stopLoading();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  //
  //
  //
  // User Logout
  void logout(BuildContext context) async {
    await _auth.signOut();
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
