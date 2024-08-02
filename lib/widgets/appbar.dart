import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp_grup_30/screens/welcome_page.dart';

class CustomAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String appBarTitle;
  final String? profilePicURL;

  const CustomAppBar(
      {super.key,
      required this.scaffoldKey,
      required this.appBarTitle,
      this.profilePicURL});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ),
        Text(
          appBarTitle,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const Expanded(
            child: Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Align(
              alignment: Alignment.centerRight, child: Icon(Icons.person)),
        ))
      ],
    );
  }
}
