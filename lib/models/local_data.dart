class CardData {
  final int id;
  final String imageUrl;
  final String gameTitle;
  final String details;
  final double rating;
  final int ratingTop;

  const CardData(
      {required this.id,
      required this.imageUrl,
      required this.gameTitle,
      required this.rating,
      required this.ratingTop,
      this.details = ""});

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
      details: json["description"],
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
