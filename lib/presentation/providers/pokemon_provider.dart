import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poekapi_app/models/pokemon.dart';

class PokemonNotifier extends StateNotifier<List<Pokemon>> {
  PokemonNotifier() : super([]);

  void addPokemonToFavourite(Pokemon pokemon) {
    if (state.contains(pokemon)) return;
    state = [...state, pokemon];
  }
}

final pokemonNotifierProvider =
    StateNotifierProvider<PokemonNotifier, List<Pokemon>>(
        (ref) => PokemonNotifier());
