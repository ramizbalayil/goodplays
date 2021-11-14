import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';

class BottomNavBar extends StatelessWidget {
  final int pageNumber;
  const BottomNavBar({Key? key, required this.pageNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, "/home_screen");
            break;
          case 1:
            Navigator.pushNamed(context, "/filter_screen");
            break;
          case 2:
            Navigator.pushNamed(context, "/explore_screen");
            break;
          case 3:
            Navigator.pushNamed(context, "/profile_screen");
            break;
        }
      },
      backgroundColor: kPrimaryColor,
      selectedItemColor: kSecondaryColor,
      unselectedItemColor: kTertiaryColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: pageNumber,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_mosaic_rounded), label: "Filter"),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
