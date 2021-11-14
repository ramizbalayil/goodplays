class CardData {
  final int id;
  final String imageUrl;
  final String gameTitle;
  final String descriptionRaw;
  final String description;
  final double rating;
  final int ratingTop;

  const CardData(
      {required this.id,
      required this.imageUrl,
      required this.gameTitle,
      required this.rating,
      required this.ratingTop,
      this.description = "",
      this.descriptionRaw = ""});

  factory CardData.fromJsonWithoutDetails(Map<String, dynamic> json) {
    return CardData(
      id: json["id"],
      gameTitle: json["name"],
      imageUrl: json["background_image"],
      rating: json["rating"],
      ratingTop: json["rating_top"],
    );
  }

  factory CardData.fromJsonWithDetails(Map<String, dynamic> json) {
    return CardData(
      id: json["id"],
      gameTitle: json["name"],
      imageUrl: json["background_image"],
      rating: json["rating"],
      descriptionRaw: json["description_raw"],
      description: json["description"],
      ratingTop: json["rating_top"],
    );
  }
}

class Genre {
  final int id;
  final String name;
  final List<GameData> gameData;
  const Genre({required this.id, required this.name, required this.gameData});

  factory Genre.fromJson(Map<String, dynamic> json) {
    List<GameData> list = [];
    for (var game in json["games"]) {
      list.add(GameData.fromJson(game));
    }
    return Genre(
      id: json["id"],
      name: json["name"],
      gameData: list,
    );
  }
}

class GameData {
  final int id;
  final String name;
  const GameData({required this.id, required this.name});
  factory GameData.fromJson(Map<String, dynamic> json) {
    return GameData(id: json["id"], name: json["name"]);
  }
}

class PageDetails {
  final List<Genre> genres;
  final List<CardData> cardDatas;
  PageDetails({required this.genres, required this.cardDatas});
}

class NetworkData {
  static PageDetails pageDetails = new PageDetails(genres: [], cardDatas: []);

  static setPageDetails(dynamic data) {
    List<Genre> tabs = [];
    List<CardData> list = [];
    if (data != null && data.length > 0) {
      tabs = data[0] as List<Genre>;
    }
    if (data != null && data.length > 1) {
      list = data[1] as List<CardData>;
    }

    PageDetails details = new PageDetails(genres: tabs, cardDatas: list);
    pageDetails = details;
  }
}
