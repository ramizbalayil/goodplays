import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';

class ProfileScreen extends StatelessWidget {
  final PageDetails pageDetails;

  const ProfileScreen({Key? key, required this.pageDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils utils = ServiceLocator.of(context)!.utils;
    return SafeArea(
      child: Container(
          color: kPrimaryColor,
          child: Column(
            children: [
              utils.buildFlexibleWidgets(1, buildProfileImageHolder(context)),
              utils.buildFlexibleWidgets(1, buildContainerForUserInfo(utils)),
            ],
          )),
    );
  }

  Container buildContainerForUserInfo(Utils utils) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            utils.buildFlexibleWidgets(
                1, buildContainerWithUserInfo("Username", "John Doe")),
            utils.buildFlexibleWidgets(
                1, buildContainerWithUserInfo("Email", "johndoe@gmail.com")),
            utils.buildFlexibleWidgets(
                1, buildContainerWithUserInfo("Gender", "Male"))
          ],
        ),
      ),
    );
  }

  Container buildContainerWithUserInfo(String key, String value) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key + ":",
            style: kTabStyle,
          ),
          Text(value, style: kTitleStyle)
        ],
      ),
    );
  }

  Container buildProfileImageHolder(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        child: Stack(
      children: [
        Positioned.fill(
            child: buildButtonIcon(height * 0.15, Icons.person, kSecondaryColor,
                Colors.white, onProfileIconPressed)),
        Positioned(
          right: 0,
          top: 20,
          child: buildButtonIcon(
              22, Icons.edit, Colors.black, kSecondaryColor, onEditIconPressed),
        )
      ],
    ));
  }

  RawMaterialButton buildButtonIcon(double height, IconData iconData,
      Color iconColor, Color bgColor, Function onPress) {
    return RawMaterialButton(
      onPressed: () => onPress(),
      child: CircleAvatar(
        radius: height,
        backgroundColor: bgColor,
        child: Icon(
          iconData,
          size: height,
          color: iconColor,
        ),
      ),
    );
  }

  void onProfileIconPressed() {
    print("Pressed");
  }

  void onEditIconPressed() {
    print("Pressed Edit");
  }
}
