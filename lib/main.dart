import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/network_manager.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/models/utils.dart';
import 'package:goodplays/screens/explore_screen.dart';
import 'package:goodplays/screens/filter_screen.dart';
import 'package:goodplays/screens/home_screen.dart';
import 'package:goodplays/screens/profile_screen.dart';
import 'package:goodplays/screens/splash_screen.dart';
import 'package:goodplays/views/bottom_navbar.dart';
import 'package:goodplays/views/app_drawer.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageNavigationBloc()),
      ],
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
    int pageNumber = context.watch<PageNavigationBloc>().pageNumber;

    return Scaffold(
      drawer: kIsWeb ? AppDrawer() : null,
      body: showSelectedScreen(pageNumber, data),
      bottomNavigationBar: kIsWeb ? null : BottomNavBar(pageNumber: pageNumber),
    );
  }

  Widget showSelectedScreen(int pageNumber, dynamic data) {
    List<Genre> tabs = [];
    List<CardData> list = [];
    if (data != null && data.length > 0) {
      tabs = data[0] as List<Genre>;
    }
    if (data != null && data.length > 1) {
      list = data[1] as List<CardData>;
    }
    List<Widget> screens = [
      HomeScreen(pageDetails: PageDetails(genres: tabs, cardDatas: list)),
      FilterScreen(pageDetails: PageDetails(genres: tabs, cardDatas: list)),
      ExploreScreen(pageDetails: PageDetails(genres: tabs, cardDatas: list)),
      ProfileScreen(pageDetails: PageDetails(genres: tabs, cardDatas: list))
    ];

    if (pageNumber < screens.length) {
      return screens[pageNumber];
    } else {
      return Container();
    }
  }
}
