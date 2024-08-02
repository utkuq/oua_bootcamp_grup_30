import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp_grup_30/firebase/firestore_crud_operations.dart';
import 'package:oua_bootcamp_grup_30/widgets/snackbar.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
    String username,
    BuildContext context,
  ) async {
    String snackBarText;
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userModel = UserModel(context: context);
      userModel.createUser(
        username: username,
        email: email,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        snackBarText = "Girmiş olduğunuz e-mail adresi zaten kayıtlı";
      } else {
        snackBarText = "Bilinmeyen bir hata oluştu. Hata kodu: ${e.code}";
      }
      final snackBar = SnackBar(
          content: Text(
        snackBarText,
        style: GoogleFonts.poppins(),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return null;
  }


}
