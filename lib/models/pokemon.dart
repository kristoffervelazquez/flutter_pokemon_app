class Pokemon {
  final String name;
  final String url;

  Pokemon({
    required this.name,
    required this.url,
  });

  // Factory constructor to create a Pokemon instance from JSON
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }

  String getId() {
    List<String> segments = Uri.parse(url).pathSegments;
    // Assuming the URL structure is consistent, and the ID is always the last segment
    String lastSegment = segments[segments.length - 2];
    // Convert the ID to an integer
    int pokemonId =
        int.tryParse(lastSegment) ?? -1; // Default to -1 if parsing fails
    return pokemonId.toString();
  }

  // // Factory constructor to create a Pokemon instance from detailed JSON
  // factory Pokemon.fromDetailsJson(Map<String, dynamic> json) {
  //   return Pokemon(
  //     name: json['name'],
  //     url: json['species']['url'], // You may adjust this based on the PokeAPI response structure
  //   );
  // }
}

class PokemonDetails {
  final int id;
  final String imageUrl;
  final String name;
  final int weight;
  final int heigth;
  final int baseExperience;

  PokemonDetails({
    required this.id,
    required this.name,
    required this.weight,
    required this.heigth,
    required this.baseExperience,
    required this.imageUrl,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      baseExperience: json['base_experience'],
      weight: json['weight'],
      heigth: json['height'],
      // Add more fields as needed
    );
  }

  Pokemon toPokemon() =>
      Pokemon(name: name, url: 'https://pokeapi.co/api/v2/pokemon/$id/');
}
