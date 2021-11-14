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
import 'package:goodplays/views/games_list.dart';
import 'package:goodplays/views/loading_spinner.dart';
import 'package:goodplays/views/page_title.dart';
import 'package:goodplays/views/subheaders.dart';

class HomeScreen extends StatelessWidget {
  final PageDetails pageDetails;
  final int pageNumber;
  const HomeScreen({Key? key, required this.pageDetails, this.pageNumber = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: kIsWeb ? AppDrawer() : null,
      bottomNavigationBar: kIsWeb ? null : BottomNavBar(pageNumber: pageNumber),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          color: kPrimaryColor,
          child: buildColumn(context),
        ),
      ),
    );
  }

  Widget buildColumn(BuildContext context) {
    Utils utils = ServiceLocator.utils;
    List<Tab> tabs = getTabList(pageDetails.genres);

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          utils.buildFlexibleWidgets(
              1,
              PageTitle(
                titleText: kHomeScreenTitle,
                iconData: Icons.search,
                onPressedFunc: () {},
              )),
          utils.buildFlexibleWidgets(1, buildTabs(tabs)),
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
      ),
    );
  }

  Widget buildGenreSpecificList(List<Genre> tabs, BuildContext context) {
    Utils utils = ServiceLocator.utils;
    NetworkBloc networkBloc = ServiceLocator.networkBloc;
    List<Widget> result = [];
    for (Genre tab in tabs) {
      result.add(utils.getFutureBuilder(
          networkBloc.getGamesFromGenre(tab.id),
          (list) => GamesList(
              cardsWidth: 0.3,
              cardsMargin: 20,
              isDetailsRequired: true,
              gameDataList: list,
              cardDataList: []),
          LoadingSpinner()));
    }
    return TabBarView(children: result);
  }
}

Widget buildTabs(List<Tab> tabs) {
  return TabBar(
    isScrollable: true,
    indicatorColor: kSecondaryColor,
    tabs: tabs,
  );
}

List<Tab> getTabList(List<Genre> genres) {
  List<Tab> result = [];
  for (Genre genre in genres) {
    result.add(Tab(text: genre.name));
  }
  return result;
}
