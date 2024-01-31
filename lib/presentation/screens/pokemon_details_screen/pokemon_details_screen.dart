import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poekapi_app/models/pokemon.dart';
import 'package:poekapi_app/presentation/providers/pokemon_provider.dart';
import 'package:poekapi_app/services/pokemons_service.dart';

class PokemonDetailsScreen extends ConsumerStatefulWidget {
  final String pokemonId;
  const PokemonDetailsScreen({super.key, required this.pokemonId});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonDetailsScreenState createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends ConsumerState<PokemonDetailsScreen> {
  bool isLoading = true;
  late PokemonDetails pokemonDetails;

  @override
  void initState() {
    fetchPokemonDetails();
    super.initState();
  }

  Future<void> fetchPokemonDetails() async {
    try {
      final details =
          await PokemonService().getPokemonDetails(widget.pokemonId);

      setState(() {
        isLoading = false;
        pokemonDetails = details;
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final bool isPokemonFavourite = ref
        .watch(pokemonNotifierProvider)
        .where((element) => element.getId() == (pokemonDetails.id.toString()))
        .isNotEmpty;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Pokemon pokemon = pokemonDetails.toPokemon();
          ref
              .read(pokemonNotifierProvider.notifier)
              .addPokemonToFavourite(pokemon);
        },
        child:
            Icon(isPokemonFavourite ? Icons.favorite : Icons.favorite_outline),
      ),
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(color: colors.primary),
              child: Image.network(
                pokemonDetails.imageUrl,
                fit: BoxFit.contain,
                height: 380,
              ),
            ),
          ),
          Positioned(
            height: 550,
            width: MediaQuery.of(context).size.width,
            top: 330,
            child: Container(
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: PokemonDetailsView(pokemon: pokemonDetails),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: colors.background,
              ),
              onPressed: () {
                context.pop();
              },
            ),
          )
        ],
      ),
    );
  }
}

class PokemonDetailsView extends StatelessWidget {
  const PokemonDetailsView({
    super.key,
    required this.pokemon,
  });

  final PokemonDetails pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          pokemon.name.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
          
        )
      ],
    );
  }
}
