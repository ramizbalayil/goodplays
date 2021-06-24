import 'package:flutter/material.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';
import 'package:goodplays/views/empty_game_card.dart';
import 'game_card.dart';

class GamesList extends StatelessWidget {
  final double cardsWidth;
  final double cardsMargin;
  final bool isDetailsRequired;
  final List<CardData> dataList;
  final List<GameData> gameDataList;
  final bool isLoadedFromFuture;
  const GamesList(
      {Key? key,
      required this.dataList,
      required this.gameDataList,
      this.cardsWidth: 0.0,
      this.cardsMargin: 0.0,
      this.isDetailsRequired: false,
      this.isLoadedFromFuture: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildListViewFromData(context),
    );
  }

  Widget buildListViewFromData(BuildContext context) {
    Utils utils = ServiceLocator.of(context)!.utils;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: isLoadedFromFuture ? gameDataList.length : dataList.length,
      itemBuilder: (context, index) {
        if (isLoadedFromFuture) {
          return utils.getFutureBuilder(
              ServiceLocator.of(context)!
                  .networkBloc
                  .getDetailsOfGame(gameDataList[index].id),
              (card) => buildGameCard(card),
              EmptyGameCard(
                  widthOfCard: cardsWidth, marginOfCard: cardsMargin));
        } else {
          return buildGameCard(dataList[index]);
        }
      },
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
