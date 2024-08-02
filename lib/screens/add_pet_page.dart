import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

// variables for pet selections
String? _selectedAnimal;
final TextEditingController _adController = TextEditingController();
final TextEditingController _turController = TextEditingController();
final TextEditingController _irkController = TextEditingController();
DateTime? _selectedDate;
final TextEditingController _rengiController = TextEditingController();
XFile? _imageFile;

// id info for pet
final TextEditingController chipNumberController = TextEditingController();
DateTime? chipDate;
final TextEditingController chipLocationController = TextEditingController();
final TextEditingController vetNameController = TextEditingController();
final TextEditingController otherController = TextEditingController();

// shot field for pets
final TextEditingController kuduzController = TextEditingController();
final TextEditingController ekinoksController = TextEditingController();
final TextEditingController antiparazitController = TextEditingController();
final TextEditingController asiController = TextEditingController();
final TextEditingController muayeneController = TextEditingController();
final TextEditingController digerController = TextEditingController();

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  Color orangeColor = const Color.fromARGB(255, 254, 165, 110);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/petpet_cat_4.png'),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 20, right: 50, left: 50),
              child: Text(
                "Eklemek istediğin hayvan türünü seçer misin?",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: orangeColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Wrap(
              spacing: 10.0, // Horizontal space between buttons
              runSpacing: 10.0, // Vertical space between rows
              children: [
                for (var label in [
                  'Kedi',
                  'Köpek',
                  'Kuş',
                  'Kaplumbağa',
                  'Balık',
                  'Diğer'
                ])
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAnimal = label;
                      });
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 60) / 2,
                      // Adjust width to fit 2 columns
                      height: 50,
                      decoration: BoxDecoration(
                        color: _selectedAnimal == label
                            ? orangeColor // Highlight selected animal
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: orangeColor),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: _selectedAnimal == label
                              ? Colors.white // Text color for selected animal
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPetPage2(),
                    ));
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
                    "İLERİ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  foregroundColor: WidgetStateProperty.all(Colors.orange)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: Center(
                  child: Text(
                    "İPTAL",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPetPage2 extends StatefulWidget {
  const AddPetPage2({super.key});

  @override
  State<AddPetPage2> createState() => _AddPetPage2State();
}

class _AddPetPage2State extends State<AddPetPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/petpet_cat_4.png'),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              child: TextField(
                controller: _adController,
                decoration: InputDecoration(
                    labelText: "Adı",
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
              ),
              child: TextField(
                controller: _turController,
                decoration: InputDecoration(
                    labelText: "Tür",
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
              ),
              child: TextField(
                //controller: _selectedDate,
                decoration: InputDecoration(
                    labelText: "Doğum Tarihi",
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
              ),
              child: TextField(
                controller: _rengiController,
                decoration: InputDecoration(
                    labelText: "Renk",
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
              ),
              child: TextField(
                controller: _irkController,
                decoration: InputDecoration(
                    labelText: "Irk",
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
              ),
              child: TextField(
                controller: _irkController,
                decoration: InputDecoration(
                    labelText: "Irk",
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
