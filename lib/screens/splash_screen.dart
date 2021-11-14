import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/service_locator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = ServiceLocator.networkBloc;

    Future.wait([bloc.getGenres(), bloc.getGames()]).then((data) {
      NetworkData.setPageDetails(data);
      Navigator.pushNamed(context, "/home_screen");
    });

    return Container(
        color: kPrimaryColor, child: Center(child: FlutterLogo(size: 100)));
  }
}
