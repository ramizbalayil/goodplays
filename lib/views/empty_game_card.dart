import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';

class EmptyGameCard extends StatelessWidget {
  final double widthOfCard;
  final double marginOfCard;
  final double borderRadiusForImage;

  const EmptyGameCard(
      {Key? key,
      this.widthOfCard: 0.0,
      this.marginOfCard: 0.0,
      this.borderRadiusForImage: 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Card(
      color: kSecondaryColor,
      margin: EdgeInsets.all(marginOfCard),
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusForImage)),
      child: SizedBox(
        width: height * widthOfCard,
        height: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadiusForImage)),
          child: Center(
            child: RefreshProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
