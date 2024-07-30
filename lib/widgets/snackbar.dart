import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(String message, BuildContext context) {
  final snackBar = SnackBar(
      content: Text(
    message,
    style: GoogleFonts.poppins(),
  ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
