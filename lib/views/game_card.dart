import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/screens/details_screen.dart';
import 'package:goodplays/data/style.dart';

class GameCard extends StatelessWidget {
  final double widthOfCard;
  final double marginOfCard;
  final CardData data;
  final bool isDetailsRequired;

  const GameCard(
      {Key? key,
      this.widthOfCard: 0.0,
      this.marginOfCard: 0.0,
      this.data: cyberpunkData,
      this.isDetailsRequired: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Card(
      color: Colors.amber,
      margin: EdgeInsets.all(marginOfCard),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () => Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => DetailsScreen(data: data))),
        child: SizedBox(
          width: height * widthOfCard,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Stack(
              children: [
                buildCardImage(),
                buildCardDetails(height),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCardDetails(double height) {
    if (!isDetailsRequired) {
      return Container();
    } else {
      return Positioned(
        bottom: 0,
        top: height * 0.3,
        right: 0,
        left: 0,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.gameTitlte,
                    style: kGameTitleStyle,
                  ),
                  Text(
                    data.publisher,
                    style: kTabStyle,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Positioned buildCardImage() {
    return Positioned.fill(
      child: Image(
        image: AssetImage(data.imageUrl),
        fit: BoxFit.cover,
      ),
    );
  }
}
