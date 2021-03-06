import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodplays/data/constants.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/network_manager.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';
import 'package:goodplays/views/app_drawer.dart';
import 'package:goodplays/views/bottom_navbar.dart';
import 'package:goodplays/views/game_card.dart';
import 'package:goodplays/views/loading_spinner.dart';
import 'package:goodplays/views/page_title.dart';
import 'details_screen.dart';

class FilterScreen extends StatelessWidget {
  final PageDetails pageDetails;
  final int pageNumber;

  const FilterScreen({Key? key, required this.pageDetails, this.pageNumber = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils utils = ServiceLocator.utils;

    return Scaffold(
        drawer: kIsWeb ? AppDrawer() : null,
        bottomNavigationBar:
            kIsWeb ? null : BottomNavBar(pageNumber: pageNumber),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            color: kPrimaryColor,
            child: Column(
              children: [
                utils.buildFlexibleWidgets(
                    1,
                    PageTitle(
                      titleText: kFilterScreenTitle,
                      iconData: Icons.tune_rounded,
                      onPressedFunc: () {},
                    )),
                utils.buildFlexibleWidgets(9, buildFilteredList(utils, context))
              ],
            ),
          ),
        ));
  }

  Container buildFilteredList(Utils utils, BuildContext context) {
    NetworkBloc bloc = ServiceLocator.networkBloc;
    int selectedTab = 0;
    int genreId = pageDetails.genres[selectedTab].id;

    return Container(
        child: utils.getFutureBuilder(
      bloc.getGamesFromGenre(genreId),
      (dataList) => buildListViewWithGameData(utils, bloc, dataList),
      LoadingSpinner(),
    ));
  }

  ListView buildListViewWithGameData(Utils u, NetworkBloc b, l) {
    return ListView.separated(
        itemBuilder: (context, index) => u.getFutureBuilder(
            b.getDetailsOfGame(l[index].id),
            (cardData) => buildListTile(cardData, context),
            LoadingSpinner()),
        separatorBuilder: (context, index) => Divider(
              color: Colors.grey[800],
            ),
        itemCount: l.length);
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
