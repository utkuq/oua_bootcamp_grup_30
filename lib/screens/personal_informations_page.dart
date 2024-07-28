import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp_grup_30/widgets/appbar.dart';
import 'package:oua_bootcamp_grup_30/widgets/side_menu.dart';

class PersonalInformationsPage extends StatefulWidget {
  const PersonalInformationsPage({super.key});

  @override
  State<PersonalInformationsPage> createState() =>
      _PersonalInformationsPageState();
}

class _PersonalInformationsPageState extends State<PersonalInformationsPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Color orangeColor = const Color.fromARGB(255, 254, 165, 1100);
    TextEditingController _nameSurname = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _phoneNumber = TextEditingController();
    TextEditingController _dateOfBirth = TextEditingController();
    TextEditingController _city = TextEditingController();
    //TextEditingController _ = TextEditingController();

    return SafeArea(
      child: Scaffold(
        drawer: const SideMenu(),
        body: Column(
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
              appBarTitle: "",
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: Text(
                  "Kişisel Bilgiler",
                  style: GoogleFonts.poppins(
                      color: orangeColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
              child: TextField(
                controller: _nameSurname,
                decoration: InputDecoration(
                    hintText: "İsim Soyisim",
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                    hintText: "E-mail",
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
              child: TextField(
                controller: _phoneNumber,
                decoration: InputDecoration(
                    hintText: "Cep Telefonu",
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
              child: TextField(
                controller: _dateOfBirth,
                decoration: InputDecoration(
                    hintText: "Doğum Tarihi",
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
              child: TextField(
                controller: _city,
                decoration: InputDecoration(
                    hintText: "Şehir",
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Image.asset("assets/icons/download.png")),
                    hintText: "Fotoğraf Ekle",
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
