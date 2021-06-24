import 'package:flutter/material.dart';

class Utils {
  Widget getFutureBuilder<T>(
      Future<T> future, Function func, Widget loadingWidget) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return func(snapshot.data as T);
        }
        return loadingWidget;
      },
    );
  }

  Flexible buildFlexibleWidgets(int flexValue, Widget w) {
    return Flexible(
      flex: flexValue,
      fit: FlexFit.tight,
      child: w,
    );
  }
}
