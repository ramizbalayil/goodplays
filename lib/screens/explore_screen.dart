import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/network_manager.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';
import 'package:goodplays/views/games_list.dart';
import 'package:goodplays/views/loading_spinner.dart';
import 'package:goodplays/views/subheaders.dart';

class ExploreScreen extends StatelessWidget {
  final PageDetails pageDetails;

  const ExploreScreen({Key? key, required this.pageDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          padding: EdgeInsets.only(left: 20, top: 20),
          color: kPrimaryColor,
          child: ListView.builder(
              itemCount: pageDetails.genres.length,
              itemBuilder: (context, index) => buildColumns(context, index))),
    );
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
    NetworkBloc networkBloc = ServiceLocator.of(context)!.networkBloc;
    Utils utils = ServiceLocator.of(context)!.utils;
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
