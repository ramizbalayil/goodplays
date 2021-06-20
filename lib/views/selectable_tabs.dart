import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/notifiers.dart';
import 'package:provider/provider.dart';

class SelectableTabs extends StatelessWidget {
  const SelectableTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: getTabs().length,
      itemBuilder: (context, index) {
        return buildTabs(index, context);
      },
    ));
  }

  List<String> getTabs() {
    return ["Featured", "Indie", "RPGs", "Casual", "Puzzle", "Board"];
  }

  Container buildTabs(int index, BuildContext context) {
    return Container(
      child: Center(
          child: TextButton(
        child: Text(getTabs()[index],
            style: context.read<NavigationBloc>().selectedTab == index
                ? kSelectedTabStyle
                : kTabStyle),
        onPressed: () => context.read<NavigationBloc>().selectedTab = index,
      )),
    );
  }
}
