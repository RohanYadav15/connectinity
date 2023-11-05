import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  late final _userReference;
  late final FirebaseFirestore firestore;
  late final FirebaseAuth fireAuth;
  late GoogleSignInAccount? user;
  late final GoogleSignIn googleSignIn;

  Authentication() {
    googleSignIn = GoogleSignIn();
    firestore = FirebaseFirestore.instance;
    fireAuth = FirebaseAuth.instance;
    _userReference = firestore.collection('Users');
  }

  Future updateData(
      String id, String username, String phoneNumber, String major) async {
    await _userReference.doc(id).update({
      'username': username,
      'phoneNumber': phoneNumber,
      major: [major]
    });
  }

  Future<CurrentUser?> loginWithGoogleSignIn() async {
    try {
      var account = await googleSignIn.signIn();
      if (account == null) return null;
      var data = await fetchUserData(account.id);
      if (data == null) {
        CurrentUser user = CurrentUser(
            phoneNumber: null,
            email: account.email,
            major: null,
            isOrg: false,
            id: account.id);
        createUserEntry(user);
        return user;
      }
    } catch (error) {
      print("sign in error: " + error.toString());
    }
  }

  Future<CurrentUser?> fetchUserData(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _userReference.doc(userId).get();
    if (doc.exists) return CurrentUser.fromMap(doc.data()!);
    return null;
  }

  Future<void> createUserEntry(CurrentUser user) async {
    final doc = await _userReference.doc(user.id).get();
    if (!doc.exists) {
      _userReference.doc(user.id).set(user.toMap());
    }
  }

  Future<void> createUserWithEP(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      CurrentUser user = CurrentUser(
          phoneNumber: null,
          email: email,
          major: [],
          isOrg: false,
          id: credential.user!.uid);
      await createUserEntry(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<CurrentUser?> signInWithEP(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = await fetchUserData(credential.user!.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }
}
