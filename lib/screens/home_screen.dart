import 'package:flutter/material.dart';
import 'package:goodplays/data/constants.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/notifiers.dart';
import 'package:goodplays/views/games_list.dart';
import 'package:goodplays/views/page_title.dart';
import 'package:goodplays/views/selectable_tabs.dart';
import 'package:goodplays/views/subheaders.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
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
                  titleText: HomeScreenTitle,
                  iconData: Icons.search,
                )),
            buildFlexibleWidgets(1, SelectableTabs()),
            buildFlexibleWidgets(5, getFutureBuilder(0.3, 20, true)),
            buildFlexibleWidgets(1, Subheader(text: "Recommended to you")),
            buildFlexibleWidgets(2, getFutureBuilder(0.15, 10, true)),
          ],
        ),
      ),
    );
  }

  Widget getFutureBuilder(double cW, double m, bool iDR) {
    return FutureBuilder(
      future: NetworkBloc().getGames(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GamesList(
            isNetwork: true,
            cardsWidth: cW,
            cardsMargin: m,
            isDetailsRequired: iDR,
            dataList: snapshot.data as List<CardData>,
          );
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
