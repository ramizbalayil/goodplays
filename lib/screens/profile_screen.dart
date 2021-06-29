import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';
import 'package:localstorage/localstorage.dart';

class ProfileScreen extends StatefulWidget {
  final PageDetails pageDetails;

  const ProfileScreen({Key? key, required this.pageDetails}) : super(key: key);

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
    "Gender": "Male"
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: kPrimaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildProfileImageHolder(context),
                buildContainerForUserInfo(context),
              ],
            ),
          )),
    );
  }

  Container buildContainerForUserInfo(BuildContext context) {
    Utils utils = ServiceLocator.of(context)!.utils;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildIndividualUserInfo("Username", userInfo),
                  buildIndividualUserInfo("Email", userInfo),
                  buildIndividualUserInfo("Gender", userInfo),
                ],
              );
            }
          }, Container())),
    );
  }

  Widget buildIndividualUserInfo(String key, dynamic userInfo) {
    return buildContainerWithUserInfo(key,
        userInfo.containsKey(key) ? userInfo[key] : defaultProfileData[key]);
  }

  Container buildContainerWithUserInfo(String key, String value) {
    if (isInEditMode) {
      return Container(
          child: TextField(
        autocorrect: false,
        onChanged: (changedValue) => {onUserProfileEdited(key, changedValue)},
        decoration: InputDecoration(labelText: key, labelStyle: kProfileStyle),
        style: kProfileStyle,
      ));
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

  void onUserProfileEdited(String key, String value) {
    print(key + " :: " + value);
    profileData[key] = value;
  }

  Container buildProfileImageHolder(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    IconData iconData = isInEditMode ? Icons.save : Icons.edit;
    return Container(
        width: double.infinity,
        height: height * 0.5,
        child: Stack(
          children: [
            Positioned.fill(
                child: buildButtonIcon(height * 0.15, Icons.person,
                    kSecondaryColor, Colors.white, onProfileIconPressed)),
            Positioned(
              right: 0,
              top: 20,
              child: buildButtonIcon(22, iconData, Colors.black,
                  kSecondaryColor, onEditIconPressed),
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
    setState(() {
      if (isInEditMode) {
        storage.setItem("userInfo", profileData);
      }
      isInEditMode = !isInEditMode;
    });
  }
}
