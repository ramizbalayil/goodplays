import 'package:flutter/material.dart';
import 'package:goodplays/data/constants.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/views/game_card.dart';
import 'package:goodplays/views/page_title.dart';

import 'details_screen.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 10),
        color: kPrimaryColor,
        child: Column(
          children: [
            buildFlexibleWidgets(
                1,
                PageTitle(
                  titleText: FilterScreenTitle,
                  iconData: Icons.tune_rounded,
                )),
            buildFlexibleWidgets(
                9,
                Container(
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          buildListTile(getListViewData()[index], context),
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.grey[800],
                          ),
                      itemCount: getListViewData().length),
                ))
          ],
        ),
      ),
    );
  }

  List<CardData> getListViewData() {
    return [
      cyberpunkData,
      witcherData,
      noMansSkyData,
      witcherData,
      cyberpunkData,
      witcherData,
      noMansSkyData
    ];
  }

  ListTile buildListTile(CardData data, BuildContext context) {
    return ListTile(
      onTap: () => onCardTapped(context, data),
      leading: GameCard(
          isTappable: false,
          widthOfCard: 0.1,
          marginOfCard: 0,
          data: data,
          borderRadiusForImage: 10,
          isDetailsRequired: false),
      title: Row(
        children: [
          Text(data.gameTitle, style: kGameTitleStyle),
          Spacer(),
          Icon(
            Icons.star_rounded,
            color: kSecondaryColor,
          ),
          Text(
            data.ratings.toString(),
            style: TextStyle(color: kSecondaryColor),
          )
        ],
      ),
      subtitle: Text(
        data.details,
        overflow: TextOverflow.ellipsis,
        style: kListTileDescriptionStyle,
      ),
    );
  }

  void onCardTapped(BuildContext context, CardData data) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => DetailsScreen(data: data)));
  }

  Flexible buildFlexibleWidgets(int flexValue, Widget w) {
    return Flexible(
      flex: flexValue,
      fit: FlexFit.tight,
      child: w,
    );
  }
}