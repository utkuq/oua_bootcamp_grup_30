import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp_grup_30/screens/sign_in_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    Color orangeColor = const Color.fromARGB(255, 254, 165, 1100);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: screenHeight / 2,
              decoration: BoxDecoration(
                color: orangeColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.elliptical(200, 100),
                  bottomRight: Radius.elliptical(200, 100),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none, // Allows overflow
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Image.asset("assets/images/logo.png")),
                  ),
                  Positioned(
                    bottom: -screenHeight /
                        11, // Adjust this value to control how much of the image overflows
                    left: 0,
                    right: 0,
                    child: Image.asset("assets/images/petpet_cat_1.png"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black, // Default color for the text
                  ),
                  children: [
                    const TextSpan(text: "En yakın "),
                    TextSpan(
                      text: "dostlarınızı",
                      style: TextStyle(color: orangeColor), // Highlight color
                    ),
                    const TextSpan(text: " güvenle takip edin"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Her anlarını kaydedin ve diğer hayvanseverlerle iletişime geçin.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 148, 148, 148)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
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
      ),
    );
  }
}
