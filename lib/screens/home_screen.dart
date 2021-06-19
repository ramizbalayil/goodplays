import 'package:flutter/material.dart';
import 'package:goodplays/styles/style.dart';
import 'package:goodplays/views/bottom_navbar.dart';
import 'package:goodplays/views/games_list.dart';
import 'package:goodplays/views/page_title.dart';
import 'package:goodplays/views/selectable_tabs.dart';
import 'package:goodplays/views/subheaders.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 10),
          color: kPrimaryColor,
          child: Column(
            children: [
              buildFlexibleWidgets(
                  1,
                  PageTitle(
                    titleText: "Home",
                  )),
              buildFlexibleWidgets(1, SelectableTabs()),
              buildFlexibleWidgets(
                  5,
                  GamesList(
                    cardsWidth: 200,
                    cardsMargin: 20,
                    isDetailsRequired: true,
                  )),
              buildFlexibleWidgets(1, Subheader(text: "Recommended to you")),
              buildFlexibleWidgets(
                  2,
                  GamesList(
                    cardsWidth: 100,
                    cardsMargin: 10,
                  )),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
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
