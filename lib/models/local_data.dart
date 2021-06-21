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

const String randomDetails =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce scelerisque sem sit amet lacus euismod tempor. Integer nec nibh vitae felis rutrum fermentum. Ut a orci in sem mattis posuere non at enim";
