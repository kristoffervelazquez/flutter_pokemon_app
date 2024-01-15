import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poekapi_app/models/pokemon.dart';
import 'package:poekapi_app/presentation/providers/pokemon_provider.dart';

class PokemonFavScreen extends ConsumerWidget {
  const PokemonFavScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Pokemon> favouritePokemons = ref.read(pokemonNotifierProvider);

    return ListView.builder(
      itemBuilder: (context, index) {
        final pokemon = favouritePokemons[index];
        final id = pokemon.getId();

        return ListTile(
          title: Text(pokemon.name.toUpperCase()),
          leading: Image.network(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png"),
          subtitle: Text(id),
          trailing: const Icon(Icons.favorite),
        );
      },
      itemCount: favouritePokemons.length,
      padding: const EdgeInsets.all(8),
    );
  }
}
