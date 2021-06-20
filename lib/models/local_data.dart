class CardData {
  final String id;
  final String imageUrl;
  final String gameTitlte;
  final String publisher;
  final String details;

  const CardData(
      {this.id = "",
      this.imageUrl = "",
      this.gameTitlte = "",
      this.publisher = "",
      this.details = randomDetails});
}

const CardData cyberpunkData = CardData(
    id: "cyberpunk",
    imageUrl: "assets/images/cyberpunk-2077.jpg",
    gameTitlte: "Cyberpunk 2077",
    publisher: "CD Projekt Red");
const CardData witcherData = CardData(
    id: "witcher",
    imageUrl: "assets/images/witcher.jpg",
    gameTitlte: "Witcher 3: Wild Hunt",
    publisher: "CD Projekt Red");
const CardData noMansSkyData = CardData(
    id: "no_mans_sky",
    imageUrl: "assets/images/no_mans_sky.jpg",
    gameTitlte: "No Man's Sky",
    publisher: "Hello Games");

const String randomDetails =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce scelerisque sem sit amet lacus euismod tempor. Integer nec nibh vitae felis rutrum fermentum. Ut a orci in sem mattis posuere non at enim";