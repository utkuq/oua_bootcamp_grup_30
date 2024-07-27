import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

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
  int _selectedIndex = 0; // Current index of the bottom navigation bar

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      key: _scaffoldKey,
      drawer: const NavigationDrawer(children: [
        SingleChildScrollView(
          child: Column(
            children: [Text("test")],
          ),
        )
      ]),
      body: Column(
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
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
              ),
              Text(
                "Hoş Geldin!",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.person),
                ),
              ))
            ],
          ),
          // Save pet box
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: GestureDetector(
              onTap: () => _showFullScreenModal(context),
              child: Container(
                decoration: BoxDecoration(
                    color: orangeColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 5.0),
                          child: Image.asset("assets/images/petpet_cat_4.png"),
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
      // **Bottom Navigation Bar with Border Radius and Padding**
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0), // Padding at the bottom
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(40),
            bottom: Radius.circular(40), // Added bottom border radius
          ),
          child: BottomAppBar(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/icons/profile.png', // Custom icon path
                    color: _selectedIndex == 0 ? orangeColor : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                    // Handle navigation
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/icons/pati.png', // Custom icon path
                    color: _selectedIndex == 1 ? orangeColor : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                    // Handle navigation
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/icons/home.png', // Custom icon path
                    color: _selectedIndex == 2 ? orangeColor : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                    // Handle navigation
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/icons/notifications.png', // Custom icon path
                    color: _selectedIndex == 3 ? orangeColor : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                    // Handle navigation
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/icons/users.png', // Custom icon path
                    color: _selectedIndex == 4 ? orangeColor : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                    // Handle navigation
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _showFullScreenModal(BuildContext context) {
    // State for selected animal
    String? _selectedAnimal;

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
                width: double.infinity, // Full width
                height: double.infinity, // Full height
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
                                    width: (MediaQuery.of(context).size.width -
                                            60) /
                                        2, // Adjust width to fit 2 columns
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: _selectedAnimal == label
                                          ? orangeColor
                                          // Highlight selected animal
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
                          Container(
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
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text('İleri'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: orangeColor,
                              backgroundColor: Colors.white, // Text color
                              side: BorderSide(
                                  color: orangeColor), // Border color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            child: Text('Close'),
                          ),
                        ],
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

  void _showNewModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              DateTime? _selectedDate;
              XFile? _imageFile;

              Future<void> _pickImage() async {
                final ImagePicker _picker = ImagePicker();
                final XFile? pickedFile = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = pickedFile;
                  });
                }
              }

              Future<void> _takePhoto() async {
                final ImagePicker _picker = ImagePicker();
                final XFile? takenFile = await _picker.pickImage(
                  source: ImageSource.camera,
                );
                if (takenFile != null) {
                  setState(() {
                    _imageFile = takenFile;
                  });
                }
              }

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
                            'Kedi Bilgileri',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: orangeColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField('Ad'),
                          const SizedBox(height: 10),
                          _buildTextField('Tür'),
                          const SizedBox(height: 10),
                          _buildTextField('Irk'),
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
                          _buildTextField('Rengi'),
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
                                        leading: Icon(Icons.camera_alt),
                                        title: Text('Fotoğraf Çek'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _takePhoto();
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.photo_library),
                                        title: Text('Galeriden Seç'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _pickImage();
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
                          Navigator.of(context).pop();
                          _showKimlikBilgileriModal(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('İleri',
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

  void _showKimlikBilgileriModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              DateTime? _chipDate;

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
                            'Kimlik Bilgileri',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: orangeColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField('Mikroçip Numarası'),
                          const SizedBox(height: 10),
                          _buildDateField(
                            context,
                            'Mikroçipin Takıldığı Tarih',
                            _chipDate,
                            (DateTime? date) {
                              setState(() {
                                _chipDate = date;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          _buildTextField('Mikroçipin Yeri'),
                          const SizedBox(height: 10),
                          _buildTextField('Pasaportu Düzenleyen Hekimin Adı'),
                          const SizedBox(height: 10),
                          _buildTextField('Diğer'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showAsiBilgileriModal(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('İleri',
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

  Widget _buildPhotoField(
      BuildContext context, XFile? imageFile, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: orangeColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageFile == null
                ? Icon(Icons.add_a_photo, size: 50, color: orangeColor)
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
                            'Aşı Bilgileri',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: orangeColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField('Kuduza Karşı Aşılama'),
                          const SizedBox(height: 10),
                          _buildTextField('Ekinoks Tedavisi'),
                          const SizedBox(height: 10),
                          _buildTextField('Diğer Antiparazitler Tedaviler'),
                          const SizedBox(height: 10),
                          _buildTextField('Diğer Aşılamalar'),
                          const SizedBox(height: 10),
                          _buildTextField('Klinik Muayene'),
                          const SizedBox(height: 10),
                          _buildTextField('Diğer'),
                        ],
                      ),
                    ),
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
                          padding: EdgeInsets.symmetric(vertical: 15),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('İleri',
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

  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: orangeColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: orangeColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
              DateTime? _dose1Date;
              DateTime? _dose2Date;
              DateTime? _dose3Date;
              String? _doseAmount;

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
                            _dose1Date,
                            (DateTime? date) {
                              setState(() {
                                _dose1Date = date;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          _buildDateField(
                            context,
                            '2. Doz Tarihi',
                            _dose2Date,
                            (DateTime? date) {
                              setState(() {
                                _dose2Date = date;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          _buildDateField(
                            context,
                            '3. Doz Tarihi',
                            _dose3Date,
                            (DateTime? date) {
                              setState(() {
                                _dose3Date = date;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          _buildDoseAmountField(
                            'Doz Miktarı',
                            _doseAmount,
                            (String? value) {
                              setState(() {
                                _doseAmount = value;
                              });
                            },
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
                          padding: EdgeInsets.symmetric(vertical: 15),
                          minimumSize: Size(double.infinity, 50),
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

  Widget _buildDoseAmountField(
    String label,
    String? value,
    Function(String?) onValueChanged,
  ) {
    return TextField(
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
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
      ),
      onChanged: onValueChanged,
    );
  }

  Widget _buildDateField(
    BuildContext context,
    String label,
    DateTime? selectedDate,
    Function(DateTime?) onDateSelected,
  ) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        onDateSelected(pickedDate);
      },
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            labelText: label,
            hintText: selectedDate != null
                ? '${selectedDate.toLocal()}'.split(' ')[0]
                : 'Seçin',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: orangeColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: orangeColor),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
          ),
        ),
      ),
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
                  : Colors.transparent,
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
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
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
      );
    }).toList();
  }
}
