import 'package:flutter/material.dart';
import 'package:goodplays/data/style.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshProgressIndicator(backgroundColor: kSecondaryColor),
    );
  }
}
