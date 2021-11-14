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
  final List<CardData> cardDataList;
  final List<GameData> gameDataList;
  const GamesList(
      {Key? key,
      required this.cardDataList,
      required this.gameDataList,
      this.cardsWidth: 0.0,
      this.cardsMargin: 0.0,
      this.isDetailsRequired: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildListViewFromData(context),
    );
  }

  List<GameData> getGameData() {
    List<GameData> list = [];

    if (gameDataList.isEmpty && cardDataList.isNotEmpty) {
      for (var data in cardDataList) {
        list.add(new GameData(id: data.id, name: data.gameTitle));
      }
    }
    if (gameDataList.isNotEmpty) {
      list = gameDataList;
    }
    return list;
  }

  Widget buildListViewFromData(BuildContext context) {
    Utils utils = ServiceLocator.utils;
    List<GameData> gameData = getGameData();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: gameData.length,
      itemBuilder: (context, index) {
        return utils.getFutureBuilder(
            ServiceLocator.networkBloc.getDetailsOfGame(gameData[index].id),
            (card) => buildGameCard(card),
            EmptyGameCard(widthOfCard: cardsWidth, marginOfCard: cardsMargin));
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
