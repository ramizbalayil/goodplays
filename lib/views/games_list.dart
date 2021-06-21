import 'package:flutter/material.dart';
import 'package:goodplays/models/local_data.dart';
import 'game_card.dart';

class GamesList extends StatelessWidget {
  final double cardsWidth;
  final double cardsMargin;
  final bool isDetailsRequired;
  final List<CardData> dataList;
  final bool isNetwork;
  const GamesList(
      {Key? key,
      required this.dataList,
      required this.isNetwork,
      this.cardsWidth: 0.0,
      this.cardsMargin: 0.0,
      this.isDetailsRequired: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildListViewFromData(),
    );
  }

  Widget buildListViewFromData() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return buildGameCard(dataList[index]);
      },
    );
  }

  GameCard buildGameCard(CardData data) {
    return GameCard(
        isNetwork: isNetwork,
        widthOfCard: cardsWidth,
        marginOfCard: cardsMargin,
        data: data,
        isDetailsRequired: this.isDetailsRequired);
  }
}
