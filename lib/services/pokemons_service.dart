
import 'dart:convert';
import 'package:poekapi_app/models/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> getPokemons(int limit, int page) async {
    final int offset = limit * page;
    print(offset);
    final response = await http.get(Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> pokemonList = data['results'];
      
      // Convert the list of dynamic to a list of Pokemon
      final List<Pokemon> pokemons = pokemonList.map((pokemonJson) => Pokemon.fromJson(pokemonJson)).toList();

      return pokemons;
    } else {
      throw Exception('Failed to load pokemons: ${response.statusCode}');
    }
  }

  Future<PokemonDetails> getPokemonDetails(String pokemonUrl) async {
    final response = await http.get(Uri.parse(pokemonUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      
      // Use the 'fromDetailsJson' factory constructor for detailed information
      return PokemonDetails.fromJson(data);
    } else {
      throw Exception('Failed to load pokemon details: ${response.statusCode}');
    }
  }
}
