import 'dart:convert';
import 'package:goodplays/models/local_data.dart';
import 'package:http/http.dart' as http;

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
    }
    return data;
  }

  Future<List<Genre>> getGenres() async {
    Uri uriParse = Uri.https(url, "/api/genres", {"key": apiKey});
    var response = await http.get(uriParse);

    List<Genre> data = [];

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<dynamic> jsonResults = json["results"];

      for (var result in jsonResults) {
        data.add(Genre.fromJson(result));
      }
    }
    return data;
  }

  Future<List<GameData>> getGamesFromGenre(int genreId) async {
    Uri uriParse = Uri.https(url, "/api/genres", {"key": apiKey});
    var response = await http.get(uriParse);

    List<GameData> data = [];

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<dynamic> jsonResults = json["results"];

      for (var result in jsonResults) {
        if (result["id"] == genreId) {
          data = getCardDataList(result);
          break;
        }
      }
    }
    return data;
  }

  List<GameData> getCardDataList(Map<String, dynamic> json) {
    List<GameData> data = [];
    for (var game in json["games"]) {
      data.add(GameData.fromJson(game));
    }
    return data;
  }

  Future<CardData> getDetailsOfGame(int gameId) async {
    Uri uriParse =
        Uri.https(url, "/api/games/" + gameId.toString(), {"key": apiKey});
    var response = await http.get(uriParse);

    CardData data;

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      data = CardData.fromJson(json);
      return data;
    } else {
      throw Exception();
    }
  }
}
