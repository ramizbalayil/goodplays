import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:goodplays/models/local_data.dart';
import 'package:http/http.dart' as http;

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

class NetworkBloc {
  String url = "api.rawg.io";
  String apiKey = "ae9c8ca2bd8340e8b28fa7841567e577";

  Future<List<CardData>> getGames() async {
    Uri uriParse = Uri.https(url, "/api/games", {"key": apiKey});
    var response = await http.get(uriParse);

    List<CardData> data = [];

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<dynamic> jsonResults = json["results"];
      for (var result in jsonResults) {
        data.add(CardData.fromJson(result));
      }
      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
