import 'package:flutter/material.dart';
import 'package:goodplays/styles/style.dart';

class SelectableTabs extends StatelessWidget {
  const SelectableTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) => ListView(
            scrollDirection: Axis.horizontal,
            children: [
              buildTabs("Featured", kSelectedTabStyle, constraints.maxHeight),
              buildTabs("Indie", kTabStyle, constraints.maxHeight),
              buildTabs("RPGs", kTabStyle, constraints.maxHeight),
              buildTabs("Casual", kTabStyle, constraints.maxHeight),
              buildTabs("Puzzle", kTabStyle, constraints.maxHeight),
              buildTabs("Board", kTabStyle, constraints.maxHeight),
            ],
          ),
        ));
  }

  Container buildTabs(String text, TextStyle textStyle, double minH) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      constraints: BoxConstraints(
        minHeight: minH,
      ),
      child: Center(child: Text(text, style: textStyle)),
    );
  }
}
