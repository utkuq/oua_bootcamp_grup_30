import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp_grup_30/screens/personal_informations_page.dart';
import 'package:oua_bootcamp_grup_30/screens/profile_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Color orangeColor = const Color.fromARGB(255, 254, 165, 1100);
    return NavigationDrawer(backgroundColor: Colors.white, children: [
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: orangeColor),
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 10),
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("assets/images/test_3.png")),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "İsim Soyisim",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35.0, top: 20),
                  child: Column(
                    children: [
                      _buildSideBarSquareButtons(
                          "Profil",
                          "assets/icons/profile.png",
                          context,
                          const ProfilePage()),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildSideBarSquareButtons(
                          "Paylaşım",
                          "assets/icons/users.png",
                          context,
                          const ProfilePage()),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildSideBarSquareButtons(
                          "Ayarlar",
                          "assets/icons/settings.png",
                          context,
                          const ProfilePage()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 35.0, top: 20.0),
                  child: Column(
                    children: [
                      _buildSideBarSquareButtons(
                          "Hayvanlarım",
                          "assets/icons/pati.png",
                          context,
                          const ProfilePage()),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildSideBarSquareButtons(
                          "Bildirimler",
                          "assets/icons/notifications.png",
                          context,
                          const ProfilePage()),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildSideBarSquareButtons(
                          "Bize Ulaşın",
                          "assets/icons/flag.png",
                          context,
                          const ProfilePage()),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            _buildSideBarRectangleButtons(
                context, "Kişisel Bilgiler", const PersonalInformationsPage()),
            const SizedBox(
              height: 20,
            ),
            _buildSideBarRectangleButtons(
                context, "Hayvan Bilgileri", const ProfilePage()),
            const SizedBox(
              height: 20,
            ),
            _buildSideBarRectangleButtons(
                context, "Mama Hatırlatıcı", const ProfilePage()),
            const SizedBox(
              height: 20,
            ),
            _buildSideBarRectangleButtons(
                context, "Bildirimler", const ProfilePage()),
          ],
        ),
      )
    ]);
  }

  Widget _buildSideBarSquareButtons(
      String buttonName, String iconPath, BuildContext context,
      [onTapRoute]) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => onTapRoute));
      },
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 245, 245, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(iconPath),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            buttonName,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: const Color.fromRGBO(121, 121, 121, 1)),
          ),
        ],
      ),
    );
  }

  Widget _buildSideBarRectangleButtons(BuildContext context, String buttonName,
      [onTapRoute]) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => onTapRoute));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(121, 121, 121, 1),
                ),
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/pati.png",
                    color: Colors.orange,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    buttonName,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(121, 121, 121, 1),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
