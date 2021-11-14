import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';

class PageTitle extends StatelessWidget {
  final String titleText;
  final IconData iconData;
  final Function onPressedFunc;
  const PageTitle(
      {Key? key,
      required this.titleText,
      required this.iconData,
      required this.onPressedFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils utils = ServiceLocator.utils;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          utils.buildFlexibleWidgets(
              1, kIsWeb ? buildDrawerButton(context) : Container()),
          utils.buildFlexibleWidgets(
              8,
              Align(
                alignment: Alignment.center,
                child: Text(
                  titleText,
                  style: kTitleStyle,
                ),
              )),
          utils.buildFlexibleWidgets(1, buildPageTitleIcon())
        ],
      ),
    );
  }

  RawMaterialButton buildPageTitleIcon() {
    return RawMaterialButton(
      onPressed: () {
        onPressedFunc();
      },
      fillColor: kSecondaryColor,
      child: Icon(
        iconData,
        size: 25.0,
      ),
      shape: CircleBorder(),
    );
  }

  RawMaterialButton buildDrawerButton(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      fillColor: kPrimaryColor,
      elevation: 0,
      child: Icon(
        Icons.menu,
        size: 25.0,
        color: Colors.white,
      ),
    );
  }
}
