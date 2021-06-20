class CardData {
  final String id;
  final String imageUrl;
  final String gameTitle;
  final String publisher;
  final String details;
  final int ratings;

  const CardData(
      {required this.id,
      required this.imageUrl,
      required this.gameTitle,
      required this.publisher,
      required this.ratings,
      this.details = randomDetails});
}

const CardData cyberpunkData = CardData(
    id: "cyberpunk",
    imageUrl: "assets/images/cyberpunk-2077.jpg",
    gameTitle: "Cyberpunk 2077",
    publisher: "CD Projekt Red",
    ratings: 10);
const CardData witcherData = CardData(
    id: "witcher",
    imageUrl: "assets/images/witcher.jpg",
    gameTitle: "Witcher 3: Wild Hunt",
    publisher: "CD Projekt Red",
    ratings: 100);
const CardData noMansSkyData = CardData(
    id: "no_mans_sky",
    imageUrl: "assets/images/no_mans_sky.jpg",
    gameTitle: "No Man's Sky",
    publisher: "Hello Games",
    ratings: 50);

const String randomDetails =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce scelerisque sem sit amet lacus euismod tempor. Integer nec nibh vitae felis rutrum fermentum. Ut a orci in sem mattis posuere non at enim";
