import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poekapi_app/models/pokemon.dart';
import 'package:poekapi_app/presentation/providers/pokemon_provider.dart';

class PokemonFavScreen extends ConsumerWidget {
  const PokemonFavScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final AuthService authService = AuthService();
    final colors = Theme.of(context).colorScheme;
    final List<Pokemon> favouritePokemons = ref.watch(pokemonNotifierProvider);

    return ListView.builder(
      itemBuilder: (context, index) {
        final pokemon = favouritePokemons[index];
        final id = pokemon.getId();

        return ListTile(
          title: Text(pokemon.name.toUpperCase()),
          leading: Image.network(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png"),
          subtitle: Text(id),
          trailing: IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Center(
                      child: ElevatedButton(
                        child: const Text("Eliminar de mi equipo"),
                        onPressed: () {
                          ref
                              .read(pokemonNotifierProvider.notifier)
                              .removePokemonFromFavourite(pokemon);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.highlight_remove_sharp, color: colors.error),
          ),
          onTap: () {
            context.push('/pokemon/$id');
          },
        );
      },
      itemCount: favouritePokemons.length,
      padding: const EdgeInsets.all(8),
    );
  }
}
