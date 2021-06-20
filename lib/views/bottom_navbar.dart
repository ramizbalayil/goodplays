import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/notifiers.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  final int pageNumber;
  const BottomNavBar({Key? key, required this.pageNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) => context.read<NavigationBloc>().pageNumber = index,
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
