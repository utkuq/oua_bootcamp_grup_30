import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  BottomBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final Color orangeColor = const Color.fromRGBO(254, 168, 100, 1);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  color: selectedIndex == 0 ? orangeColor : Colors.grey,
                ),
                onPressed: () => onItemTapped(0),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/icons/pati.png', // Custom icon path
                  color: selectedIndex == 1 ? orangeColor : Colors.grey,
                ),
                onPressed: () => onItemTapped(1),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/icons/home.png', // Custom icon path
                  color: selectedIndex == 2 ? orangeColor : Colors.grey,
                ),
                onPressed: () => onItemTapped(2),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/icons/notifications.png',
                  color: selectedIndex == 3 ? orangeColor : Colors.grey,
                ),
                onPressed: () => onItemTapped(3),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/icons/users.png', // Custom icon path
                  color: selectedIndex == 4 ? orangeColor : Colors.grey,
                ),
                onPressed: () => onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
