import 'package:flutter/material.dart';
import 'package:goodplays/styles/style.dart';

class PageTitle extends StatelessWidget {
  final String titleText;
  const PageTitle({Key? key, this.titleText = ""}) : super(key: key);

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
        Icons.search,
        size: 25.0,
      ),
      shape: CircleBorder(),
    );
  }
}
