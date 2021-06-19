import 'package:flutter/material.dart';
import 'package:goodplays/models/local_data.dart';
import 'game_card.dart';

class GamesList extends StatelessWidget {
  final double cardsWidth;
  final double cardsMargin;
  final bool isDetailsRequired;

  const GamesList(
      {Key? key,
      this.cardsWidth: 0.0,
      this.cardsMargin: 0.0,
      this.isDetailsRequired: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) => ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildGameCard(cyberpunkData),
            buildGameCard(witcherData),
            buildGameCard(noMansSkyData),
            buildGameCard(witcherData),
            buildGameCard(cyberpunkData),
          ],
        ),
      ),
    );
  }

  GameCard buildGameCard(CardData data) {
    return GameCard(
        widthOfCard: cardsWidth,
        marginOfCard: cardsMargin,
        data: data,
        isDetailsRequired: this.isDetailsRequired);
  }
}
