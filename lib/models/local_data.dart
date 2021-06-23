class CardData {
  final int id;
  final String imageUrl;
  final String gameTitle;
  final String details;
  final int ratings;
  final double rating;
  final int ratingTop;

  const CardData(
      {required this.id,
      required this.imageUrl,
      required this.gameTitle,
      required this.ratings,
      required this.rating,
      required this.ratingTop,
      this.details = randomDetails});

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      ratings: 100,
      id: json["id"],
      gameTitle: json["name"],
      imageUrl: json["background_image"],
      rating: json["rating"],
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

const String randomDetails =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce scelerisque sem sit amet lacus euismod tempor. Integer nec nibh vitae felis rutrum fermentum. Ut a orci in sem mattis posuere non at enim";
