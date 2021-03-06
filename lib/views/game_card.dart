import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/screens/details_screen.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/views/loading_spinner.dart';

class GameCard extends StatelessWidget {
  final double widthOfCard;
  final double marginOfCard;
  final CardData data;
  final double borderRadiusForImage;
  final bool isDetailsRequired;
  final bool isTappable;

  const GameCard(
      {Key? key,
      this.widthOfCard: 0.0,
      this.marginOfCard: 0.0,
      required this.data,
      this.borderRadiusForImage: 30,
      this.isDetailsRequired: false,
      this.isTappable: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Card(
      color: kTertiaryColor,
      margin: EdgeInsets.all(marginOfCard),
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusForImage)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: isTappable ? () => onCardTapped(context) : null,
        child: SizedBox(
          width: height * widthOfCard,
          height: double.infinity,
          child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(borderRadiusForImage)),
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

  void onCardTapped(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => DetailsScreen(data: data)));
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
                    data.gameTitle,
                    style: kGameTitleStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget buildCardImage() {
    return Positioned.fill(
        child: CachedNetworkImage(
      imageUrl: data.imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => LoadingSpinner(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ));
  }
}
