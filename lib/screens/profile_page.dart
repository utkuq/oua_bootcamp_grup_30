import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oua_bootcamp_grup_30/widgets/appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  String? username;
  Future getDocId() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(user!.email).get();
    setState(() {
    username = documentSnapshot["username"];

    });

  }

  @override
  void initState() {
    getDocId();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Color orangeColor = const Color.fromARGB(255, 254, 165, 110);
    Color backgroundColor =
        const Color.fromRGBO(245, 245, 245, 1); // Background color of the page
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          CustomAppBar(scaffoldKey: _scaffoldKey, appBarTitle: ""),
          const Icon(Icons.person),
          Text(username != null ? username! : "username"),

        ],
      ),
    ));
  }
}
