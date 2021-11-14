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

class ExploreScreen extends StatelessWidget {
  final PageDetails pageDetails;
  final int pageNumber;

  const ExploreScreen(
      {Key? key, required this.pageDetails, this.pageNumber = 0})
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
                        titleText: kExploreScreenTitle,
                        iconData: Icons.search,
                        onPressedFunc: () {},
                      )),
                  utils.buildFlexibleWidgets(
                      9,
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: ListView.builder(
                            itemCount: pageDetails.genres.length,
                            itemBuilder: (context, index) =>
                                buildColumns(context, index)),
                      )),
                ],
              )),
        ));
  }

  Widget buildColumns(BuildContext context, int index) {
    return Column(children: [
      Subheader(text: pageDetails.genres[index].name),
      SizedBox(height: 10),
      SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
        child: buildGenreSpecificList(context, pageDetails.genres[index].id),
      ),
      SizedBox(height: 10),
    ]);
  }

  Widget buildGenreSpecificList(BuildContext context, int genreId) {
    NetworkBloc networkBloc = ServiceLocator.networkBloc;
    Utils utils = ServiceLocator.utils;
    return utils.getFutureBuilder(
        networkBloc.getGamesFromGenre(genreId),
        (list) => GamesList(
            cardsWidth: 0.15,
            cardsMargin: 10,
            isDetailsRequired: false,
            gameDataList: list,
            cardDataList: []),
        LoadingSpinner());
  }
}
