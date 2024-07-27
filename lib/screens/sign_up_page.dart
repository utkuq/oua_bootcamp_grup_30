import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp_grup_30/screens/describe_yourself_page.dart';
import 'package:oua_bootcamp_grup_30/screens/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    Color orangeColor = const Color.fromARGB(255, 254, 165, 1100);
    TextEditingController email = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController passwordVerify = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight / 4,
                decoration: BoxDecoration(
                  color: orangeColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset("assets/images/petpet_cat_2.png"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Aramıza Hoş Geldin!",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 32),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: TextField(
                  controller: email,
                  decoration: const InputDecoration(
                      hintText: "E-posta",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: TextField(
                  controller: username,
                  decoration: const InputDecoration(
                      hintText: "Kullanıcı Adı",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, bottom: 30, top: 30),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Şifre",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
                child: TextField(
                  controller: passwordVerify,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Şifre (Tekrar)",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                ),
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DescribeYourselfPage(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: orangeColor),
                  child: Text(
                    "Kayıt Ol",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Zaten hesabın var mı?",
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ));
                  },
                  child: Text(
                    "Giriş Yap",
                    style:
                        GoogleFonts.poppins(fontSize: 18, color: orangeColor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
