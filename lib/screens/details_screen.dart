import 'package:flutter/material.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/data/style.dart';

class DetailsScreen extends StatelessWidget {
  final CardData data;
  const DetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: kPrimaryColor,
          child: Stack(
            children: [
              buildDetailsImage(true),
              buildBackButton(context),
              buildDetails(size),
              buildDetailsScreenButtons(size)
            ],
          ),
        ),
      ),
    );
  }

  Positioned buildDetailsScreenButtons(Size size) {
    return Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Container(
            height: size.height * 0.085,
            child: Row(
              children: [
                Flexible(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: buildElevatedButton(Text(
                          "Download",
                          style: kButtonStyle,
                        )),
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: buildElevatedButton(Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      )),
                    )),
              ],
            )));
  }

  ElevatedButton buildElevatedButton(Widget w) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kSecondaryColor,
        minimumSize: Size(double.infinity, double.infinity),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      onPressed: () => {},
      child: w,
    );
  }

  Widget buildBackButton(BuildContext context) {
    return Positioned(
        top: 10,
        left: -10,
        child: RawMaterialButton(
          onPressed: () => Navigator.pop(context),
          fillColor: kPrimaryColor.withOpacity(0.7),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20.0,
          ),
          shape: CircleBorder(),
        ));
  }

  Widget buildDetails(Size size) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, controller) => ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        child: Container(
            color: kPrimaryColor.withOpacity(0.95),
            child: SingleChildScrollView(
              controller: controller,
              child: buildContainerWithDetails(size),
            )),
      ),
    );
  }

  Container buildContainerWithDetails(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.5,
      child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetailsHeader(),
              SizedBox(
                height: 5,
              ),
              buildTextForDetailsScreen("Publisher", kTabStyle),
              SizedBox(
                height: 25,
              ),
              buildTextForDetailsScreen("Summary", kSubheaderStyle),
              SizedBox(
                height: 25,
              ),
              buildTextForDetailsScreen(data.details, kGameTitleStyle),
            ],
          )),
    );
  }

  Row buildDetailsHeader() {
    return Row(
      children: [
        Text(
          data.gameTitle,
          style: kTitleStyle,
          overflow: TextOverflow.ellipsis,
        ),
        Spacer(),
        Row(
          children: [
            Icon(
              Icons.star_rounded,
              color: kSecondaryColor,
            ),
            Text(
              data.ratings.toString(),
              style: kRatingsStyleDetails,
            )
          ],
        )
      ],
    );
  }

  Text buildTextForDetailsScreen(String text, TextStyle styleForText) {
    return Text(
      text,
      style: styleForText,
    );
  }

  Positioned buildDetailsImage(bool isNetwork) {
    if (isNetwork) {
      return Positioned.fill(
        child: Image.network(
          data.imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      );
    } else {
      return Positioned.fill(
        child: Image(
          image: AssetImage(data.imageUrl),
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
