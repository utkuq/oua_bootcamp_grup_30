import 'package:flutter/material.dart';
import 'package:oua_bootcamp_grup_30/screens/home_page.dart';
import 'package:oua_bootcamp_grup_30/screens/notifications.dart';
import 'package:oua_bootcamp_grup_30/screens/pet_details_page.dart';
import 'package:oua_bootcamp_grup_30/screens/profile_page.dart';
import 'package:oua_bootcamp_grup_30/screens/social_page.dart';
import 'package:oua_bootcamp_grup_30/widgets/bottombar.dart';

class PageHolder extends StatefulWidget {
  const PageHolder({super.key});

  @override
  _PageHolderState createState() => _PageHolderState();
}

class _PageHolderState extends State<PageHolder> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }


  void _navigateToSecondPage() {
    setState(() {
      _selectedIndex = 2;
    });
    _pageController.jumpToPage(2);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToSecondPage();
    });
  }


  @override
  Widget build(BuildContext context) {
    //_navigateToSecondPage();
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const <Widget>[
          ProfilePage(),
          PetDetailsPage(petName: ""),
          HomePage(),
          NotificationsPage(),
          SocialPage(),
        ],
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
