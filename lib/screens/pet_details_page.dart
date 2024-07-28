import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp_grup_30/widgets/appbar.dart';
import 'package:oua_bootcamp_grup_30/widgets/side_menu.dart';

class PetDetailsPage extends StatefulWidget {
  final String petName;

  const PetDetailsPage({super.key, required this.petName});

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color orangeColor = const Color.fromARGB(255, 254, 165, 1100);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        drawer: const SideMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
              CustomAppBar(
                scaffoldKey: _scaffoldKey,
                appBarTitle: "",
              ),
              // pet name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 10),
                    child: Text(
                      widget.petName,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              // TODO: BURAYA GELECEK GÖRSELİN FIREBASE ÜZERİNDEN GELMESİ GEREKİYOR
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 40.0, right: 40.0, bottom: 20.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Image.asset("assets/images/test_1.png"),
                  ),
                ),
              ),
              // tab
              DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                            labelColor: orangeColor,
                            indicatorColor: orangeColor,
                            dividerColor: Colors.transparent,
                            labelStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            tabs: const [
                              Tab(text: 'Hayvana ait bilgiler'),
                              Tab(text: 'Aşı bilgileri'),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: 500, //height of TabBarView
                            child: TabBarView(children: <Widget>[
                              Container(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 40.0, right: 40.0, top: 20),
                                          child: _generateAnimalDetailsField(
                                              "Boncuk",
                                              "Kedi",
                                              "Scottish Fold Longhair",
                                              "Erkek",
                                              "01.12.2022",
                                              "Silver",
                                              "11111111111",
                                              "01.01.2023",
                                              "İki Scapula Arası",
                                              "Ali Yılmaz"))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 40.0, right: 40.0, top: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Kuduza karşı aşılama",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Diğer antiparazit tedavileri",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Klinik muayene",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Ekinokok tedavisi",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Diğer aşılamalar",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                "Diğer",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                            ]))
                      ])),
            ],
          ),
        ),
      )),
    );
  }

  Widget _generateAnimalDetailsField(
      animalName,
      animalSpecies,
      animalRace,
      animalGender,
      animalDateOfBirth,
      animalColor,
      microChipNumber,
      microChipInstallDate,
      microChipLocation,
      microChipDoctorName) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Adı",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: orangeColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                animalName,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Tür",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: orangeColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                animalSpecies,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Irk",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: orangeColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                animalRace,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Cinsiyet",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: orangeColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                animalGender,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Doğum Tarihi",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: orangeColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                animalDateOfBirth,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Rengi",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: orangeColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                animalColor,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hayvanın Kimlik Bilgileri",
                overflow: TextOverflow.clip,
                softWrap: true,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: orangeColor,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Mikroçip Numarası",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: orangeColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                microChipNumber,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Mikroçip Takılma Tarihi",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: orangeColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                microChipInstallDate,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Mikroçip Yeri",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: orangeColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                microChipLocation,
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Pasaportu Düzenleyen Hekim",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: orangeColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                microChipDoctorName,
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
