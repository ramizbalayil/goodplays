import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';

class PageTitle extends StatelessWidget {
  final String titleText;
  final IconData iconData;
  const PageTitle({Key? key, required this.titleText, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: kTitleStyle,
          ),
          Spacer(),
          buildPageTitleIcon()
        ],
      ),
    );
  }

  RawMaterialButton buildPageTitleIcon() {
    return RawMaterialButton(
      onPressed: () {},
      fillColor: kSecondaryColor,
      child: Icon(
        iconData,
        size: 25.0,
      ),
      shape: CircleBorder(),
    );
  }
}
