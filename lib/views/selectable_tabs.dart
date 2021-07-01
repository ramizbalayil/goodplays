import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:goodplays/models/notifiers.dart';
import 'package:provider/provider.dart';

class SelectableTabs extends StatelessWidget {
  final List<Genre> tabs;
  const SelectableTabs({Key? key, required this.tabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: tabs.length,
      itemBuilder: (context, index) {
        return buildTabs(index, context);
      },
    ));
  }

  Container buildTabs(int index, BuildContext context) {
    return Container(
      child: Center(
          child: TextButton(
        child: Text(tabs[index].name,
            style: context.watch<TabNavigationBloc>().selectedTab == index
                ? kSelectedTabStyle
                : kTabStyle),
        onPressed: () => context.read<TabNavigationBloc>().selectedTab = index,
      )),
    );
  }
}
