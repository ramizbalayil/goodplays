import 'package:flutter/material.dart';
import 'package:goodplays/data/constants.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';
import 'package:goodplays/views/game_card.dart';
import 'package:goodplays/views/page_title.dart';
import 'details_screen.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = ServiceLocator.of(context)!.networkBloc;
    Utils utils = ServiceLocator.of(context)!.utils;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 10),
        color: kPrimaryColor,
        child: Column(
          children: [
            utils.buildFlexibleWidgets(
                1,
                PageTitle(
                  titleText: FilterScreenTitle,
                  iconData: Icons.tune_rounded,
                )),
            utils.buildFlexibleWidgets(
                9,
                Container(
                  child: FutureBuilder(
                    future: bloc.getGames(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        List<CardData> dataList =
                            snapshot.data as List<CardData>;
                        return ListView.separated(
                            itemBuilder: (context, index) =>
                                buildListTile(dataList[index], context),
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey[800],
                                ),
                            itemCount: dataList.length);
                      }
                      return Center(child: RefreshProgressIndicator());
                    },
                  ),
                ))
          ],
        ),
      ),
    );
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
            style: kRatingsStyleFilter,
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
}
