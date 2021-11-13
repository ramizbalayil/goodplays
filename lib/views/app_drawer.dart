import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/notifiers.dart';
import 'package:provider/src/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: kPrimaryColor,
      child: ListView(
        children: [
          buildListTile(Icons.home, "Home", context, 0),
          buildListTile(
              Icons.auto_awesome_mosaic_rounded, "Filter", context, 1),
          buildListTile(Icons.explore, "Explore", context, 2),
          buildListTile(Icons.person, "Profile", context, 3),
        ],
      ),
    ));
  }

  ListTile buildListTile(
      IconData data, String label, BuildContext context, int pageNumber) {
    return ListTile(
        onTap: () {
          context.read<PageNavigationBloc>().pageNumber = pageNumber;
          Navigator.pop(context);
        },
        leading: Icon(
          data,
          color: kSecondaryColor,
        ),
        title: Text(
          label,
          style: TextStyle(color: kSecondaryColor),
        ));
  }
}
