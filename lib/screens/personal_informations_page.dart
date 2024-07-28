import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oua_bootcamp_grup_30/widgets/appbar.dart';
import 'package:oua_bootcamp_grup_30/widgets/side_menu.dart';

class PersonalInformationsPage extends StatefulWidget {
  const PersonalInformationsPage({super.key});

  @override
  State<PersonalInformationsPage> createState() =>
      _PersonalInformationsPageState();
}

class _PersonalInformationsPageState extends State<PersonalInformationsPage> {
  bool passwordVisible1 = false;
  bool passwordVisible2 = false;
  bool passwordVisible3 = false;
  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _newPasswordCheck = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible1 = true;
    passwordVisible2 = true;
    passwordVisible3 = true;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Color orangeColor = const Color.fromARGB(255, 254, 165, 1100);
    TextEditingController _nameSurname = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _phoneNumber = TextEditingController();
    TextEditingController _dateOfBirth = TextEditingController();
    TextEditingController _city = TextEditingController();
    XFile? _imageFile;

    return SafeArea(
      child: Scaffold(
        drawer: const SideMenu(),
        body: SingleChildScrollView(
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
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
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
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
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
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
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
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
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
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
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
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.camera_alt),
                                        title: const Text('Fotoğraf Çek'),
                                        onTap: () async {
                                          Navigator.pop(context);
                                          await _takePhoto(_imageFile);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.photo),
                                        title: const Text('Galeriden Seç'),
                                        onTap: () async {
                                          Navigator.pop(context);
                                          await _pickImage(_imageFile);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: Image.asset("assets/icons/download.png")),
                      hintText: "Fotoğraf Ekle",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor: WidgetStateProperty.all(Colors.orange),
                        foregroundColor: WidgetStateProperty.all(Colors.white)),
                    child: Text(
                      "Kaydet",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor: WidgetStateProperty.all(Colors.orange),
                        foregroundColor: WidgetStateProperty.all(Colors.white)),
                    child: Text(
                      "Çıkış Yap",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            WidgetStateProperty.all(Colors.grey[700]),
                        foregroundColor: WidgetStateProperty.all(Colors.white)),
                    child: Text(
                      "Hesabımı Sil",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 30),
                  child: Text(
                    "Şifrenizi Yenileyin",
                    style: GoogleFonts.poppins(
                        color: orangeColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 24),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                child: TextField(
                  obscureText: passwordVisible1,
                  controller: _currentPassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible1
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            passwordVisible1 = !passwordVisible1;
                          });
                        },
                      ),
                      hintText: "Mevcut Şifre",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                child: TextField(
                  obscureText: passwordVisible2,
                  controller: _newPassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible2
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            passwordVisible2 = !passwordVisible2;
                          });
                        },
                      ),
                      hintText: "Yeni Şifre",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                child: TextField(
                  obscureText: passwordVisible3,
                  controller: _newPasswordCheck,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible3
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            passwordVisible3 = !passwordVisible3;
                          });
                        },
                      ),
                      hintText: "Yeni Şifre (tekrar)",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 80),
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor: WidgetStateProperty.all(Colors.orange),
                      foregroundColor: WidgetStateProperty.all(Colors.white)),
                  child: Text(
                    "Kaydet",
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _takePhoto(
    imageFile,
  ) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? takenFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (takenFile != null) {
      setState(() {
        imageFile = takenFile;
      });
    }
  }

  Future<void> _pickImage(imageFile) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  }
}
