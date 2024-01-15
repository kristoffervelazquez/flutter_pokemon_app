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
    String lastSegment = segments[segments.length-2];
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
  final String imageUrl;

  PokemonDetails({
    required this.imageUrl,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      imageUrl: json['sprites']['front_default'],
      // Add more fields as needed
    );
  }
}
