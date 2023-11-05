import 'package:connectnity/models/authentication.dart';
import 'package:connectnity/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  CurrentUser? user;
  Authentication authentication = Authentication();

  UserProvider() {
    authentication.googleSignIn.onCurrentUserChanged.listen((account) {
      if (account == null) {
        user = null;
        notifyListeners();
      } else {
        authentication.fetchUserData(account.id).then((value) {
          user = value;
          notifyListeners();
        });
      }
    });
    authentication.fireAuth.authStateChanges().listen((newUser) {
      if (newUser == null) user = null;
      authentication.fetchUserData(newUser!.uid).then((value) {
        user = value;
      });
      notifyListeners();
    });
  }

  void login() async {
    this.user = await authentication.loginWithGoogleSignIn();
    notifyListeners();
  }

  void signOut() async {
    await authentication.googleSignIn.signOut();
  }

  void signInSilently() async {
    await authentication.googleSignIn.signInSilently();
  }

  void createUserWithEmailAndPassword(String email, String password) async {
    await authentication.createUserWithEP(email, password);
  }

  void signInWithEp(String email, String password) async {
    authentication.signInWithEP(email, password);
  }

  void updateUserData(String username, String phoneNumber, String major) async {
    await authentication.updateData(user!.id, username, phoneNumber, major);
    user = await authentication.fetchUserData(user!.id);
    notifyListeners();
  }
}
