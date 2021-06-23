import 'package:flutter/material.dart';
import 'package:goodplays/data/constants.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/views/games_list.dart';
import 'package:goodplays/views/page_title.dart';
import 'package:goodplays/views/selectable_tabs.dart';
import 'package:goodplays/views/subheaders.dart';

class HomeScreen extends StatelessWidget {
  final dynamic data;
  const HomeScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 10),
        color: kPrimaryColor,
        child: buildColumn(data),
      ),
    );
  }

  Widget buildColumn(dynamic data) {
    List<Genre> tabs = [];
    List<CardData> list = [];
    if (data != null && data.length > 0) {
      tabs = data[0] as List<Genre>;
    }
    if (data != null && data.length > 1) {
      list = data[1] as List<CardData>;
    }
    return buildColumnForHomeScreen(tabs, list);
  }

  Column buildColumnForHomeScreen(List<Genre> tabs, List<CardData> list) {
    return Column(
      children: [
        buildFlexibleWidgets(
            1,
            PageTitle(
              titleText: HomeScreenTitle,
              iconData: Icons.search,
            )),
        buildFlexibleWidgets(1, SelectableTabs(tabs: tabs)),
        buildFlexibleWidgets(
          5,
          GamesList(
              cardsWidth: 0.3,
              cardsMargin: 20,
              isDetailsRequired: true,
              dataList: list),
        ),
        buildFlexibleWidgets(1, Subheader(text: "Recommended to you")),
        buildFlexibleWidgets(
            2,
            GamesList(
              cardsWidth: 0.15,
              cardsMargin: 10,
              isDetailsRequired: false,
              dataList: list,
            )),
      ],
    );
  }

  Widget getFutureBuilder<T>(Future<T> future, Function func) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return func(snapshot.data as T);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Flexible buildFlexibleWidgets(int flexValue, Widget w) {
    return Flexible(
      flex: flexValue,
      fit: FlexFit.tight,
      child: w,
    );
  }
}
