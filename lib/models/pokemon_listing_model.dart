class PokemonListingModel {
  final int id;
  final String name;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  PokemonListingModel({required this.id, required this.name});

  factory PokemonListingModel.fromJson(Map<String, dynamic> json) {
    final name = json["name"];
    final url = json["url"] as String;
    final id = int.parse(url.split('/')[6]);

    return PokemonListingModel(id: id, name: name);
  }
}
