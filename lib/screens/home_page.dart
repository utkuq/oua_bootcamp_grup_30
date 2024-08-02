import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp_grup_30/firebase/firestore_crud_operations.dart';
import 'package:oua_bootcamp_grup_30/screens/add_pet_page.dart';
import 'package:oua_bootcamp_grup_30/screens/pet_details_page.dart';
import 'package:oua_bootcamp_grup_30/widgets/appbar.dart';
import 'package:oua_bootcamp_grup_30/widgets/side_menu.dart';
import '../screens/notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color orangeColor = const Color.fromARGB(255, 254, 165, 110);
  Color backgroundColor =
      const Color.fromRGBO(245, 245, 245, 1); // Background color of the page
  String? selectedCategory;

  // add a new animal page controllers
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

  Future<void> _savePet() async {
    if (_selectedAnimal != null &&
        _adController.text.isNotEmpty &&
        _turController.text.isNotEmpty &&
        _irkController.text.isNotEmpty &&
        _selectedDate != null &&
        _rengiController.text.isNotEmpty &&
        _imageFile != null &&
        chipNumberController.text.isNotEmpty &&
        chipDate != null &&
        chipLocationController.text.isNotEmpty &&
        vetNameController.text.isNotEmpty &&
        kuduzController.text.isNotEmpty &&
        ekinoksController.text.isNotEmpty &&
        antiparazitController.text.isNotEmpty &&
        asiController.text.isNotEmpty &&
        muayeneController.text.isNotEmpty) {
      UserModel userModel = UserModel(context: context);
      String imageURL = await userModel.uploadImageGetURL(_imageFile!);

      Map<String, dynamic> fields = {
        "selected_animal": _selectedAnimal!,
        "pet_name": _adController.text,
        "pet_type": _turController.text,
        "pet_race": _irkController.text,
        "selected_date": _selectedDate.toString(),
        "pet_color": _rengiController.text,
        "pet_image": imageURL,
        "microchip_number": chipNumberController.text,
        "microchip_install_date": chipDate.toString(),
        "microchip_location": chipLocationController.text,
        "microchip_installed_vet": vetNameController.text,
        "rabies": kuduzController.text,
        "equinox": ekinoksController.text,
        "anti-parasite": antiparazitController.text,
        "vaccination": asiController.text,
        "examination": muayeneController.text,
      };
      await userModel.addPet(fields: fields);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      key: _scaffoldKey,
      drawer: const SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            // Custom AppBar
            CustomAppBar(scaffoldKey: _scaffoldKey, appBarTitle: "Hoş Geldin!"),
            // Save pet box
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: GestureDetector(
                // onTap: () => _showFullScreenModal(context),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddPetPage(),
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: orangeColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10, right: 5.0),
                            child:
                                Image.asset("assets/images/petpet_cat_4.png"),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                "Dostlarını kaydet ve her anlarını takip et!",
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Spacer(),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.add_circle_outline_outlined,
                                color: Colors.white,
                                size: 40,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // 'Kategoriler' title
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text(
                  "Kategoriler",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
            ),
            // 'Kategoriler' buttons
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildSelectableContainer("Kedi", "Kedi"),
                    _buildSelectableContainer("Köpek", "Köpek"),
                    _buildSelectableContainer("Kuş", "Kuş"),
                    _buildSelectableContainer("Kaplumbağa", "Kaplumbağa"),
                  ],
                ),
              ),
            ),
            // Pets
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _buildFilteredAnimalCards(),
                  )),
            )
          ],
        ),
      ),
    ));
  }

  void _showFullScreenModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          true, // Allows dismissing by tapping outside the modal
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero, // Remove default padding
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: MediaQuery.of(context).size.width, // Full width
                height: MediaQuery.of(context).size.height, // Full height
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:
                                  Image.asset('assets/images/petpet_cat_4.png'),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Eklemek istediğin hayvan türünü seçer misin?',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: orangeColor),
                            ),
                            const SizedBox(height: 20),
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
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  60) /
                                              2,
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
                                              ? Colors
                                                  .white // Text color for selected animal
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.8, // Make the "İleri" button wider
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_selectedAnimal != null) {
                                    Navigator.of(context)
                                        .pop(); // Close the current dialog

                                    // Show the new modal
                                    _showNewModal(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: orangeColor, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                ),
                                child: Text(
                                  'İleri',
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: orangeColor,
                                backgroundColor: Colors.white,
                                // Text color
                                side: BorderSide(color: orangeColor),
                                // Border color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                'İptal',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showNewModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
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

              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:
                                  Image.asset('assets/images/petpet_cat_4.png'),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Evcil Hayvan Bilgileri',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: orangeColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildTextField('Ad', _adController),
                            const SizedBox(height: 10),
                            _buildTextField('Tür', _turController),
                            const SizedBox(height: 10),
                            _buildTextField('Irk', _irkController),
                            const SizedBox(height: 10),
                            _buildDateField(
                              context,
                              'Doğum Tarihi',
                              _selectedDate,
                              (DateTime? date) {
                                setState(() {
                                  _selectedDate = date;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            _buildTextField('Rengi', _rengiController),
                            const SizedBox(height: 20),
                            _buildPhotoField(
                              context,
                              _imageFile,
                              () {
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
                                          leading:
                                              const Icon(Icons.photo_library),
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
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Close the current dialog
                            _showKimlikBilgileriModal(
                                context); // Show the next modal
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: orangeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text('İleri',
                              style: GoogleFonts.poppins(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showKimlikBilgileriModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                    'assets/images/petpet_cat_4.png'),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Kimlik Bilgileri',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: orangeColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                  'Mikroçip Numarası', chipNumberController),
                              const SizedBox(height: 10),
                              _buildDateField(
                                context,
                                'Mikroçipin Takıldığı Tarih',
                                chipDate,
                                (DateTime? date) {
                                  setState(() {
                                    chipDate = date;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              _buildTextField(
                                  'Mikroçipin Yeri', chipLocationController),
                              const SizedBox(height: 10),
                              _buildTextField(
                                  'Pasaportu Düzenleyen Hekimin Adı',
                                  vetNameController),
                              const SizedBox(height: 10),
                              _buildTextField('Diğer', otherController),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            _showAsiBilgileriModal(
                                context); // Show the next modal
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: orangeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text('İleri',
                              style: GoogleFonts.poppins(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPhotoField(
      BuildContext context, XFile? imageFile, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: orangeColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageFile == null
                ? Icon(Icons.add_a_photo,
                    size: 70,
                    color: orangeColor) // Burada boyut ve renk ayarlandı
                : Image.file(
                    File(imageFile.path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 10),
            Text(
              imageFile == null ? 'Fotoğraf Ekle' : 'Fotoğraf Yüklendi',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAsiBilgileriModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset('assets/images/petpet_cat_4.png'),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Aşı Bilgileri',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: orangeColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                            'Kuduza Karşı Aşılama', kuduzController),
                        const SizedBox(height: 10),
                        _buildTextField('Ekinoks Tedavisi', ekinoksController),
                        const SizedBox(height: 10),
                        _buildTextField('Diğer Antiparazitler Tedaviler',
                            antiparazitController),
                        const SizedBox(height: 10),
                        _buildTextField('Diğer Aşılamalar', asiController),
                        const SizedBox(height: 10),
                        _buildTextField('Klinik Muayene', muayeneController),
                        const SizedBox(height: 10),
                        _buildTextField('Diğer', digerController),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _showDigerAsilamalarModal(context);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: orangeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: Text('İleri',
                                style: GoogleFonts.poppins(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildDoseAmountField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: 'Sayı Girin',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: orangeColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: orangeColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      ),
    );
  }

  void _showDigerAsilamalarModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              DateTime? dose1Date;
              DateTime? dose2Date;
              DateTime? dose3Date;

              // Controller for the dose amount field
              final TextEditingController doseAmountController =
                  TextEditingController();

              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child:
                                Image.asset('assets/images/petpet_cat_4.png'),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Diğer Aşılamalar',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: orangeColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildDateField(
                            context,
                            '1. Doz Tarihi',
                            dose1Date,
                            (DateTime? date) {
                              setState(() {
                                dose1Date = date;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          _buildDateField(
                            context,
                            '2. Doz Tarihi',
                            dose2Date,
                            (DateTime? date) {
                              setState(() {
                                dose2Date = date;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          _buildDateField(
                            context,
                            '3. Doz Tarihi',
                            dose3Date,
                            (DateTime? date) {
                              setState(() {
                                dose3Date = date;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          _buildDoseAmountField(
                            'Doz Miktarı',
                            doseAmountController,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text('Kaydet',
                            style: GoogleFonts.poppins(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDateField(BuildContext context, String label,
      DateTime? selectedDate, Function(DateTime?) onDateSelected) {
    return InkWell(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null && pickedDate != selectedDate) {
          onDateSelected(pickedDate);
        }
      },
      child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: selectedDate == null
              ? null
              : Text(
                  '${selectedDate.toLocal()}'.split(' ')[0],
                  style: GoogleFonts.poppins(fontSize: 16),
                )),
    );
  }

  Widget _buildSelectableContainer(String value, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: selectedCategory == value
                  ? orangeColor.withOpacity(0.5)
                  : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.all(2.0),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              right: 25.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: Text(text,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 20)),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFilteredAnimalCards() {
    // List of all animals
    final animals = [
      {
        'name': 'Boncuk',
        'age': '1,5',
        'gender': 'Erkek',
        'imagePath': 'assets/images/test_1.png',
        'category': 'Kedi'
      },
      {
        'name': 'Muttiş',
        'age': '5',
        'gender': 'Dişi',
        'imagePath': 'assets/images/test_2.png',
        'category': 'Köpek'
      },
      // Add more animals with categories here
    ];

    // Filter animals based on selected category
    final filteredAnimals = selectedCategory == null
        ? animals
        : animals
            .where((animal) => animal['category'] == selectedCategory)
            .toList();

    return filteredAnimals.map((animal) {
      return Padding(
        padding: const EdgeInsets.only(left: 35),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetDetailsPage(
                    petName: animal['name']!,
                  ),
                ));
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  Image.asset(animal['imagePath']!),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      animal['name']!,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${animal['age']} yaş",
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Text(
                        animal['gender']!,
                        style: GoogleFonts.poppins(fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
