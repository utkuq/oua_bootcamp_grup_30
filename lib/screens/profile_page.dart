import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:oua_bootcamp_grup_30/firebase/firestore_crud_operations.dart';
import 'package:oua_bootcamp_grup_30/widgets/appbar.dart';
import 'package:oua_bootcamp_grup_30/widgets/side_menu.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  String? username;
  String? nameSurname;
  String? phoneNumber;
  String? city;
  String? dateOfBirth;
  TextEditingController isimSoyisimController = TextEditingController();
  TextEditingController cepTelefonuController = TextEditingController();
  TextEditingController sehirController = TextEditingController();
  DateTime? dogumTarihiController;

  Future getDocId() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.email)
        .get();
    setState(() {
      username = documentSnapshot["username"];
      nameSurname = documentSnapshot["name_surname"] ?? null;
      phoneNumber = documentSnapshot["phone_number"] ?? null;
      city = documentSnapshot["city"] ?? null;
      dateOfBirth = documentSnapshot["date_of_birth"] ?? null;
    });
  }

  Future setFields() async {
    await getDocId();
    setState(() {
        isimSoyisimController.text = nameSurname ?? "";
        cepTelefonuController.text = phoneNumber ?? "";
        sehirController.text = city! ?? "";
        dogumTarihiController = DateFormat("dd/MM/yyyy").parse(dateOfBirth!) ?? null;

    });
  }

  @override
  void initState() {
    setFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Color orangeColor = const Color.fromARGB(255, 254, 165, 110);
    Color backgroundColor =
        const Color.fromRGBO(245, 245, 245, 1); // Background color of the page
    return Scaffold(
      drawer: const SideMenu(),
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            CustomAppBar(
                scaffoldKey: _scaffoldKey,
                appBarTitle: username != null ? username! : ""),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text("Profil",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: orangeColor)),
              ),
            ),
            const Icon(
              Icons.person,
              size: 150,
            ),
            //const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                top: 15.0,
              ),
              child: TextField(
                controller: isimSoyisimController,
                decoration: InputDecoration(
                    labelText: "İsim Soyisim",
                    labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                top: 15.0,
              ),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    //labelText: user!.email,
                    hintText: user!.email,
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                top: 15.0,
              ),
              child: TextField(
                controller: cepTelefonuController,
                decoration: InputDecoration(
                    labelText: "Cep Telefonu",
                    labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                top: 15.0,
                bottom: 15,
              ),
              child: TextField(
                controller: sehirController,
                decoration: InputDecoration(
                    labelText: "Şehir",
                    labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            TextButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  setState(() {
                    dogumTarihiController = pickedDate;
                  });
                }
              },
              style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  foregroundColor: WidgetStateProperty.all(Colors.grey)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        dogumTarihiController != null
                            ? "Doğum Tarihi: ${DateFormat("dd/MM/yyyy").format(dogumTarihiController!)}"
                            : "Doğum Tarihi",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () async {
                  if (isimSoyisimController.text.isNotEmpty &&
                      cepTelefonuController.text.isNotEmpty &&
                      sehirController.text.isNotEmpty &&
                      dogumTarihiController != null) {
                    UserModel userModel = UserModel(context: context);
                    userModel.updateData(
                        field: "name_surname",
                        value: isimSoyisimController.text);
                    userModel.updateData(
                        field: "phone_number",
                        value: cepTelefonuController.text);
                    userModel.updateData(
                        field: "city", value: sehirController.text);
                    userModel.updateData(
                        field: "date_of_birth",
                        value: DateFormat("dd/MM/yyyy")
                            .format(dogumTarihiController!));
                  }
                },
                style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: WidgetStateProperty.all(Colors.orange),
                    foregroundColor: WidgetStateProperty.all(Colors.white)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 40,
                  child: Center(
                    child: Text(
                      "DÜZENLE",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
