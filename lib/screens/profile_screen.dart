import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodplays/data/constants.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';
import 'package:goodplays/views/app_drawer.dart';
import 'package:goodplays/views/bottom_navbar.dart';
import 'package:goodplays/views/page_title.dart';
import 'package:localstorage/localstorage.dart';

class ProfileScreen extends StatefulWidget {
  final int pageNumber;

  const ProfileScreen({Key? key, this.pageNumber = 0}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isInEditMode = false;
  final LocalStorage storage = new LocalStorage('goodplays');

  Map<String, String> profileData = {};
  Map<String, String> defaultProfileData = {
    "Username": "John Doe",
    "Email": "johndoe@gmail.com",
    "Age": "0"
  };

  @override
  Widget build(BuildContext context) {
    Utils utils = ServiceLocator.utils;

    return Scaffold(
        drawer: kIsWeb ? AppDrawer() : null,
        bottomNavigationBar:
            kIsWeb ? null : BottomNavBar(pageNumber: widget.pageNumber),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            color: kPrimaryColor,
            child: Column(
              children: [
                utils.buildFlexibleWidgets(
                    1,
                    PageTitle(
                      titleText: kProfileScreenTitle,
                      iconData: isInEditMode ? Icons.save : Icons.edit,
                      onPressedFunc: () {
                        onEditIconPressed();
                      },
                    )),
                utils.buildFlexibleWidgets(
                    9,
                    Container(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          buildProfileImageHolder(context),
                          buildContainerForUserInfo(context),
                        ],
                      ),
                    ))),
              ],
            ),
          ),
        ));
  }

  Container buildContainerForUserInfo(BuildContext context) {
    Utils utils = ServiceLocator.utils;

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.all(20),
      child: SizedBox(
          width: double.infinity,
          child: utils.getFutureBuilder(storage.ready, (isReady) {
            if (isReady) {
              dynamic userInfo = storage.getItem("userInfo");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildIndividualUserInfo(
                      "Username", userInfo, TextInputType.name),
                  buildIndividualUserInfo(
                      "Email", userInfo, TextInputType.emailAddress),
                  buildIndividualUserInfo(
                      "Age", userInfo, TextInputType.number),
                ],
              );
            }
          }, Container())),
    );
  }

  Widget buildIndividualUserInfo(
      String key, dynamic userInfo, TextInputType type) {
    return buildContainerWithUserInfo(
        key,
        userInfo != null && userInfo.containsKey(key)
            ? userInfo[key]
            : defaultProfileData[key],
        type);
  }

  Container buildContainerWithUserInfo(
      String key, String value, TextInputType type) {
    if (isInEditMode) {
      return buildContainerWithTextField(key, value, type);
    } else {
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
  }

  Container buildContainerWithTextField(
      String key, String value, TextInputType type) {
    return Container(
        child: TextField(
      autocorrect: false,
      keyboardType: type,
      onChanged: (changedValue) => {onUserProfileEdited(key, changedValue)},
      decoration: InputDecoration(
          labelText: key,
          labelStyle: kProfileStyle,
          hintText: value,
          hintStyle: kTabStyle),
      style: kProfileStyle,
    ));
  }

  void onUserProfileEdited(String key, String value) {
    profileData[key] = value;
  }

  Container buildProfileImageHolder(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        width: double.infinity,
        height: height * 0.5,
        child: Stack(
          children: [
            Positioned.fill(
                child: buildButtonIcon(height * 0.15, Icons.person,
                    kSecondaryColor, Colors.white, onProfileIconPressed)),
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
    print("onEditIconPressed");
    setState(() {
      if (isInEditMode) {
        storage.setItem("userInfo", profileData);
      }
      isInEditMode = !isInEditMode;
    });
  }
}
