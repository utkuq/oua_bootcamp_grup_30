import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp_grup_30/screens/add_pet_page.dart';
import 'package:oua_bootcamp_grup_30/screens/pet_details_page.dart';
import 'package:oua_bootcamp_grup_30/widgets/appbar.dart';
import 'package:oua_bootcamp_grup_30/widgets/side_menu.dart';

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
