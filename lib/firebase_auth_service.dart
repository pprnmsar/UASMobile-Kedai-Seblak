import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  FirebaseAuth _authService = FirebaseAuth.instance;

  Future<User?> signUpWithEmailandPassword(
      String username, notlpn, email, password, BuildContext context) async {
    try {
      UserCredential credential = await _authService
          .createUserWithEmailAndPassword(email: email, password: password);
          
      String uid = credential.user?.uid ?? "";
      print("UID: $uid");

      var response = await Dio().post(
        'https://seblak-6cf5a-default-rtdb.firebaseio.com/users.json',
        data: {
          'uid': uid,
          'username': username,
          'no_tlpn': notlpn,
        },
      );

      if (response.statusCode == 200) {
        print("Response Data: ${response.data}");
        return credential.user;
      } else {
        print("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      final String errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<User?> loginWithEmailandPassword(
      String email, password, BuildContext context) async {
    try {
      UserCredential credential = await _authService.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      final String errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
