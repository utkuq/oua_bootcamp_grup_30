import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oua_bootcamp_grup_30/widgets/snackbar.dart';
import 'package:intl/intl.dart';

import '../firebase/firestore_crud_operations.dart';

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
DateTime? kuduzController;
DateTime? ekinoksController;
DateTime? antiparazitController;
DateTime? muayeneController;

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
                if (_selectedAnimal != null) {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPetPage2(),
                      ));
                } else {
                  showSnackBar(
                      "Lütfen bir seçenek seçerek devam ediniz", context);
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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/petpet_cat_4.png'),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    top: 30.0,
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
                    top: 15.0,
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
                    top: 15.0,
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
                    top: 15.0,
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
                const SizedBox(
                  height: 15,
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
                        _selectedDate = pickedDate;
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
                            _selectedDate != null
                                ? DateFormat("dd-MM-yyyy")
                                    .format(_selectedDate!)
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
                  height: 15,
                ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Fotoğraf Çek'),
                              onTap: () {
                                Navigator.pop(context);
                                takePhoto();
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Galeriden Seç'),
                              onTap: () {
                                Navigator.pop(context);
                                pickImage();
                              },
                            ),
                          ],
                        );
                      },
                    );
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
                          Icon(Icons.camera_alt),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            _imageFile == null
                                ? "Fotoğraf Ekle"
                                : "Fotoğraf Yüklendi",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    if (_adController.text.isNotEmpty &&
                        _turController.text.isNotEmpty &&
                        _irkController.text.isNotEmpty &&
                        _selectedDate != null &&
                        _rengiController.text.isNotEmpty &&
                        _imageFile != null) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPetPage3(),
                          ));
                    } else {
                      showSnackBar("Lütfen bütün alanları doldurunuz", context);
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
                        "İLERİ",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? takenFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (takenFile != null) {
      setState(() {
        _imageFile = takenFile;
      });
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }
}

class AddPetPage3 extends StatefulWidget {
  const AddPetPage3({super.key});

  @override
  State<AddPetPage3> createState() => _AddPetPage3State();
}

class _AddPetPage3State extends State<AddPetPage3> {
  Color orangeColor = const Color.fromARGB(255, 254, 165, 110);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/petpet_cat_4.png'),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20, right: 50, left: 50),
                  child: Text(
                    "Evcil Hayvanın Kimlik Bilgileri",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: orangeColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: TextField(
                    controller: chipNumberController,
                    decoration: InputDecoration(
                        labelText: "Mikroçip Numarası",
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
                    controller: chipLocationController,
                    decoration: InputDecoration(
                        labelText: "Mikroçipin Yeri",
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
                    controller: vetNameController,
                    decoration: InputDecoration(
                        labelText: "Pasaportu Düzenleyen Veteriner Hekimin Adı",
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
                    controller: otherController,
                    decoration: InputDecoration(
                        labelText: "Diğer",
                        hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                        chipDate = pickedDate;
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
                            chipDate != null
                                ? DateFormat("dd-MM-yyyy").format(chipDate!)
                                : "Mikroçipin Takıldığı Tarih",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    if (chipNumberController.text.isNotEmpty &&
                        chipLocationController.text.isNotEmpty &&
                        vetNameController.text.isNotEmpty &&
                        chipDate != null) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPetPage4(),
                          ));
                    } else {
                      showSnackBar("Lütfen bütün alanları doldurunuz", context);
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
                        "İLERİ",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddPetPage4 extends StatefulWidget {
  const AddPetPage4({super.key});

  @override
  State<AddPetPage4> createState() => _AddPetPage4State();
}

class _AddPetPage4State extends State<AddPetPage4> {
  Color orangeColor = const Color.fromARGB(255, 254, 165, 110);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/petpet_cat_4.png'),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20, right: 50, left: 50),
                  child: Text(
                    "Aşı Bilgileri",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: orangeColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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
                        kuduzController = pickedDate;
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
                        children: [
                          Icon(Icons.calendar_month),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            kuduzController != null
                                ? "Kuduz Aşısı: ${DateFormat("dd-MM-yyyy").format(kuduzController!)}"
                                : "Kuduz Aşısı Tarihi",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                        ekinoksController = pickedDate;
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
                        children: [
                          Icon(Icons.calendar_month),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            ekinoksController != null
                                ? "Ekinoks Tedavisi: ${DateFormat("dd-MM-yyyy").format(ekinoksController!)}"
                                : "Ekinoks Tedavisi Tarihi",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                        antiparazitController = pickedDate;
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
                        children: [
                          Icon(Icons.calendar_month),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            antiparazitController != null
                                ? "Diğer Antiparazit Tedavileri: ${DateFormat("dd-MM-yyyy").format(antiparazitController!)}"
                                : "Diğer Antiparazit Tedavileri Tarihi",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                        muayeneController = pickedDate;
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
                        children: [
                          Icon(Icons.calendar_month),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            muayeneController != null
                                ? "Klinik Muayene: ${DateFormat("dd-MM-yyyy").format(muayeneController!)}"
                                : "Klinik Muayene Tarihi",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () async {
                    if (kuduzController != null &&
                        ekinoksController != null &&
                        antiparazitController != null &&
                        muayeneController != null) {
                      UserModel userModel = UserModel(context: context);

                      String imageURL =
                          await userModel.uploadImageGetURL(_imageFile!);

                      await userModel.addPet(fields: {
                        "selected_animal": _selectedAnimal!,
                        "pet_name": _adController.text,
                        "pet_kind": _turController.text,
                        "pet_race": _irkController.text,
                        "pet_color": _rengiController.text,
                        "pet_date_of_birth":
                            DateFormat("dd-MM-yyyy").format(_selectedDate!),
                        "pet_image": imageURL,
                        "microchip_number": chipNumberController.text,
                        "microchip_location": chipLocationController.text,
                        "microchip_date":
                            DateFormat("dd-MM-yyyy").format(chipDate!),
                        "vet_name": vetNameController.text,
                        "other": otherController.text,
                        "kuduz":
                            DateFormat("dd-MM-yyyy").format(kuduzController!),
                        "ekinoks":
                            DateFormat("dd-MM-yyyy").format(ekinoksController!),
                        "antiparazit": DateFormat("dd-MM-yyyy")
                            .format(antiparazitController!),
                        "muayene":
                            DateFormat("dd-MM-yyyy").format(muayeneController!),
                      });
                      Navigator.pop(context);
                    } else {
                      showSnackBar("Lütfen bütün alanları doldurunuz", context);
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
                        "KAYDET",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
