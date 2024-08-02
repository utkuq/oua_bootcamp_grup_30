import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oua_bootcamp_grup_30/widgets/snackbar.dart';

class UserModel {
  BuildContext context;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel({required this.context});

  Future<void> createUser({
    required String username,
    required String email,
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
    required String field,
    required String value,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String email = user.email!;
        await _firestore.collection("users").doc(email).update({
          field: value,
        });
      }
    } catch (e) {}
  }

  Future<void> addPet({required Map<String, dynamic> fields}) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String email = user.email!;
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(email).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>? ?? {};
        Map<String, dynamic> pets;

        if (data.containsKey('pets')) {
          pets = data['pets'] as Map<String, dynamic>;
          String newPetKey =
              'pet_${pets.length + 1}'; // Define a key for the new pet
          pets[newPetKey] = fields;
          await _firestore
              .collection('users')
              .doc(email)
              .update({'pets': pets});
        } else {
          pets = {};
          String newPetKey =
              'pet_${pets.length + 1}'; // Define a key for the new pet
          pets[newPetKey] = fields;
          await _firestore.collection('users').doc(email).update({'pets': pets});
        }
      }
    }
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

  Future<String> uploadImageGetURL(XFile image) async {
    try {
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceImageDir = referenceRoot.child("images");

      String uniqueImageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceImage = referenceImageDir.child(uniqueImageName);

      await referenceImage.putFile(File(image.path));
      String imageURL = await referenceImage.getDownloadURL();
      return imageURL;
    } catch (e) {
      return e.toString();
    }
  }
}
