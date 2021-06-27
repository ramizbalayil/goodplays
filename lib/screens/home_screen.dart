import 'package:flutter/material.dart';
import 'package:goodplays/data/constants.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/network_manager.dart';
import 'package:goodplays/models/notifiers.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';
import 'package:goodplays/views/games_list.dart';
import 'package:goodplays/views/loading_spinner.dart';
import 'package:goodplays/views/page_title.dart';
import 'package:goodplays/views/selectable_tabs.dart';
import 'package:goodplays/views/subheaders.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final PageDetails pageDetails;

  const HomeScreen({Key? key, required this.pageDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 10),
        color: kPrimaryColor,
        child: buildColumn(context),
      ),
    );
  }

  Widget buildColumn(BuildContext context) {
    return buildColumnForHomeScreen(context);
  }

  Column buildColumnForHomeScreen(BuildContext context) {
    Utils utils = ServiceLocator.of(context)!.utils;

    return Column(
      children: [
        utils.buildFlexibleWidgets(
            1,
            PageTitle(
              titleText: HomeScreenTitle,
              iconData: Icons.search,
            )),
        utils.buildFlexibleWidgets(1, SelectableTabs(tabs: pageDetails.genres)),
        utils.buildFlexibleWidgets(
          5,
          buildGenreSpecificList(pageDetails.genres, context),
        ),
        utils.buildFlexibleWidgets(1, Subheader(text: "Recommended to you")),
        utils.buildFlexibleWidgets(
            2,
            GamesList(
              cardsWidth: 0.15,
              cardsMargin: 10,
              isDetailsRequired: false,
              gameDataList: [],
              cardDataList: pageDetails.cardDatas,
            )),
      ],
    );
  }

  Widget buildGenreSpecificList(List<Genre> tabs, BuildContext context) {
    int selectedTab = context.watch<NavigationBloc>().selectedTab;
    NetworkBloc networkBloc = ServiceLocator.of(context)!.networkBloc;
    Utils utils = ServiceLocator.of(context)!.utils;
    return utils.getFutureBuilder(
        networkBloc.getGamesFromGenre(tabs[selectedTab].id),
        (list) => GamesList(
            cardsWidth: 0.3,
            cardsMargin: 20,
            isDetailsRequired: true,
            gameDataList: list,
            cardDataList: []),
        LoadingSpinner());
  }
}
