import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp_grup_30/firebase/firestore_crud_operations.dart';
import 'package:oua_bootcamp_grup_30/screens/home_page.dart';

class DescribeYourselfPage extends StatefulWidget {
  const DescribeYourselfPage({super.key});

  @override
  State<DescribeYourselfPage> createState() => _DescribeYourselfPageState();
}

class _DescribeYourselfPageState extends State<DescribeYourselfPage> {
  String? selectedDefinition;

  @override
  Widget build(BuildContext context) {
    Color orangeColor = const Color.fromARGB(255, 254, 165, 1100);
    return SafeArea(
        child: Scaffold(
      body: ListView(children: [
        Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            Image.asset("assets/images/petpet_cat_3.png"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Text(
                "Kendini nasıl tanımlarsın?",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),
            _buildSelectableContainer("Hayvan Sahibi", "Hayvan Sahibi"),
            _buildSelectableContainer("Hayvansever", "Hayvansever"),
            _buildSelectableContainer(
                "Hayvan Hakları STK Üyesi", "Hayvan Hakları STK Üyesi"),
            _buildSelectableContainer("Diğer", "Diğer"),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  UserModel userModel = UserModel(context: context);
                  await userModel.updateData(
                      field: "owner_description", value: selectedDefinition!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                },
                style: ElevatedButton.styleFrom(backgroundColor: orangeColor),
                child: Text(
                  "Devam Et",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ]),
    ));
  }

  Widget _buildSelectableContainer(String value, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDefinition = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 80, right: 80, bottom: 15),
        child: Container(
          decoration: BoxDecoration(
              color: selectedDefinition == value
                  ? Colors.orangeAccent.withOpacity(0.8)
                  : Colors.orangeAccent.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              )),
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            title: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: selectedDefinition == value
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
