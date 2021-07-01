import 'package:flutter/material.dart';

class PageNavigationBloc extends ChangeNotifier {
  int _pageNo = 0;

  int get pageNumber => _pageNo;

  set pageNumber(int value) {
    _pageNo = value;
    notifyListeners();
  }
}

class TabNavigationBloc extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  set selectedTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }
}
