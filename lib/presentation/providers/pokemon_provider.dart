import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poekapi_app/models/pokemon.dart';

class PokemonNotifier extends StateNotifier<List<Pokemon>> {
  PokemonNotifier() : super([]);

  void addPokemonToFavourite(Pokemon pokemon) {
    if(state.where((element) => element.getId() == pokemon.getId()).isNotEmpty) return;
    state = [...state, pokemon];
  }

  void removePokemonFromFavourite(Pokemon pokemon) {
    final filteredList = state.where((e) =>  e != pokemon).toList();
    state = filteredList;
  }
}

final pokemonNotifierProvider =
    StateNotifierProvider<PokemonNotifier, List<Pokemon>>(
        (ref) => PokemonNotifier());
