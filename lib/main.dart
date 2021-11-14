import 'package:flutter/material.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/screens/explore_screen.dart';
import 'package:goodplays/screens/filter_screen.dart';
import 'package:goodplays/screens/home_screen.dart';
import 'package:goodplays/screens/profile_screen.dart';
import 'package:goodplays/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goodplays',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/home_screen": (context) =>
            HomeScreen(pageDetails: NetworkData.pageDetails, pageNumber: 0),
        "/filter_screen": (context) =>
            FilterScreen(pageDetails: NetworkData.pageDetails, pageNumber: 1),
        "/explore_screen": (context) =>
            ExploreScreen(pageDetails: NetworkData.pageDetails, pageNumber: 2),
        "/profile_screen": (context) => ProfileScreen(pageNumber: 3),
      },
    );
  }
}
