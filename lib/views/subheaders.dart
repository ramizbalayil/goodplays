import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';

class Subheader extends StatelessWidget {
  final String text;
  const Subheader({Key? key, this.text: ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: kSubheaderStyle,
      ),
    );
  }
}
