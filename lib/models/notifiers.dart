import 'package:flutter/material.dart';

class NavigationBloc extends ChangeNotifier {
  int _pageNo = 0;
  int _selectedTab = 0;

  int get pageNumber => _pageNo;
  int get selectedTab => _selectedTab;

  set pageNumber(int value) {
    _pageNo = value;
    notifyListeners();
  }

  set selectedTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }
}
