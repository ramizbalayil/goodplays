import 'package:flutter/material.dart';

class PageNavigationBloc extends ChangeNotifier {
  int _pageNo = 0;

  int get pageNumber => _pageNo;

  set pageNumber(int value) {
    _pageNo = value;
    notifyListeners();
  }
}
