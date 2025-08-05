import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evently/firebase/firebase_manager.dart';
import 'package:evently/models/user_model.dart';

class AppProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;

  AppProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    userModel = await FirebaseManager.readUser();
    notifyListeners();
  }
}
