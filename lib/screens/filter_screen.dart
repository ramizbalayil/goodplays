import 'package:flutter/material.dart';
import 'package:goodplays/data/constants.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/network_manager.dart';
import 'package:goodplays/models/notifiers.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';
import 'package:goodplays/views/game_card.dart';
import 'package:goodplays/views/loading_spinner.dart';
import 'package:goodplays/views/page_title.dart';
import 'details_screen.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  final PageDetails pageDetails;

  const FilterScreen({Key? key, required this.pageDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NetworkBloc bloc = ServiceLocator.of(context)!.networkBloc;
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
                    child: utils.getFutureBuilder(
                  bloc.getGamesFromGenre(pageDetails
                      .genres[context.watch<TabNavigationBloc>().selectedTab]
                      .id),
                  (dataList) {
                    return ListView.separated(
                        itemBuilder: (context, index) => utils.getFutureBuilder(
                            bloc.getDetailsOfGame(dataList[index].id),
                            (cardData) => buildListTile(cardData, context),
                            LoadingSpinner()),
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.grey[800],
                            ),
                        itemCount: dataList.length);
                  },
                  LoadingSpinner(),
                )))
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
          Text(
            data.rating.toStringAsFixed(1) +
                "/" +
                data.ratingTop.toStringAsFixed(1),
            style: kRatingsStyleFilter,
          )
        ],
      ),
      subtitle: Text(
        data.descriptionRaw,
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
