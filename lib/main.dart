import 'package:flutter/material.dart';
import 'package:goodplays/models/service_locator.dart';
import 'package:goodplays/screens/filter_screen.dart';
import 'package:goodplays/screens/home_screen.dart';
import 'package:goodplays/views/bottom_navbar.dart';
import 'package:provider/provider.dart';
import 'models/notifiers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationBloc(),
      child: MaterialApp(
        title: 'Goodplays',
        debugShowCheckedModeBanner: false,
        home: ServiceLocator(
          child: AppScaffold(),
          networkBloc: NetworkBloc(),
        ),
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationBloc navBarBloc = Provider.of<NavigationBloc>(context);

    return Scaffold(
      body: showSelectedScreen(navBarBloc.pageNumber),
      bottomNavigationBar: BottomNavBar(pageNumber: navBarBloc.pageNumber),
    );
  }

  Widget showSelectedScreen(int pageNumber) {
    List<Widget> screens = [HomeScreen(), FilterScreen()];

    if (pageNumber < screens.length) {
      return screens[pageNumber];
    } else {
      return Container();
    }
  }
}
