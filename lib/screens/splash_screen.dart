import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kPrimaryColor, child: Center(child: FlutterLogo(size: 100)));
  }
}
