import 'package:flutter/material.dart';
import 'package:goodplays/models/network_manager.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';
import 'package:goodplays/screens/filter_screen.dart';
import 'package:goodplays/screens/home_screen.dart';
import 'package:goodplays/screens/splash_screen.dart';
import 'package:goodplays/views/bottom_navbar.dart';
import 'package:provider/provider.dart';
import 'models/notifiers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = NetworkBloc();
    var utils = Utils();

    return ChangeNotifierProvider(
      create: (context) => NavigationBloc(),
      child: MaterialApp(
        title: 'Goodplays',
        debugShowCheckedModeBanner: false,
        home: ServiceLocator(
          child: utils.getFutureBuilder(
              Future.wait([bloc.getGenres(), bloc.getGames()]),
              (data) => AppScaffold(data: data),
              SplashScreen()),
          networkBloc: bloc,
          utils: utils,
        ),
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  final dynamic data;
  const AppScaffold({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationBloc navBarBloc = Provider.of<NavigationBloc>(context);

    return Scaffold(
      body: showSelectedScreen(navBarBloc.pageNumber, data),
      bottomNavigationBar: BottomNavBar(pageNumber: navBarBloc.pageNumber),
    );
  }

  Widget showSelectedScreen(int pageNumber, dynamic data) {
    List<Widget> screens = [HomeScreen(data: data), FilterScreen()];

    if (pageNumber < screens.length) {
      return screens[pageNumber];
    } else {
      return Container();
    }
  }
}
