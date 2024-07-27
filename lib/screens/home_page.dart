import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp_grup_30/screens/pet_details_page.dart';
import 'package:oua_bootcamp_grup_30/widgets/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color orangeColor = const Color.fromARGB(255, 254, 165, 1100);
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 10),
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
          //Logo
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
              onTap: () {},
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

          //Pets

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildAnimalCards(
                        "Boncuk", "1,5", "Erkek", "assets/images/test_1.png"),
                    _buildAnimalCards(
                        "Muttiş", "5", "Dişi", "assets/images/test_2.png"),
                  ],
                )),
          ),
        ],
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
                  ? Colors.orangeAccent.withOpacity(0.5)
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

  // TODO: GÖRSELLERİN FIREBASE ÜZERİNDEN ÇEKİLMESİ GEREKİYOR
  Widget _buildAnimalCards(
      String name, String age, String gender, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetDetailsPage(
                petName: name,
              ),
            ));
      },
      child: Padding(
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
                Image.asset(imagePath),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
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
                      "$age yaş",
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Text(
                      gender,
                      style: GoogleFonts.poppins(fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
