import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oua_bootcamp_grup_30/widgets/snackbar.dart';

class UserModel {
  BuildContext context;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel({required this.context});

  Future<void> createUser({
    String? username,
    String? email,
  }) async {
    try {
      await _firestore.collection('users').doc(email).set({
        'username': username,
        'email': email,
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar("Bilinmeyen bir hata oluştu. Hata kodu: ${e.code}", context);
    }
  }

  Future<void> updateData({
    String? field,
    String? value,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String email = user.email!;
        await _firestore.collection("users").doc(email).update({
          field!: value,
        });
      }
    } catch (e) {}
  }

  Future<void> readData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String email = user.email!;
        DocumentSnapshot document =
            await _firestore.collection('users').doc(email).get();
        if (document.exists) {
          showSnackBar("${document.data}", context);
        }
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }
}
