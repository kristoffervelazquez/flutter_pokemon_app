import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poekapi_app/models/pokemon.dart';
import 'package:poekapi_app/presentation/providers/pokemon_provider.dart';
import 'package:poekapi_app/services/pokemons_service.dart';

class PokemonsScreen extends StatefulWidget {
  const PokemonsScreen({super.key});

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen> {
  final PokemonService pokemonService = PokemonService();
  late List<Pokemon> pokemons = [];
  bool isLoading = false;
  int page = 0;
  // ignore: constant_identifier_names
  static const LIMIT_PER_PAGE = 12;

  @override
  void initState() {
    super.initState();
    fetchPokemons(LIMIT_PER_PAGE, page);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    return Scaffold(
      body: _PokemonsView(pokemons: pokemons, page: page),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                if (page <= 0) return;

                page--;
                fetchPokemons(LIMIT_PER_PAGE, page);
              },
              child: const Icon(Icons.arrow_back),
              // child: Text(page.toString()),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () {
                page++;
                fetchPokemons(LIMIT_PER_PAGE, page);
              },
              child: const Icon(Icons.arrow_forward),
              // child: Text(page.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchPokemons(int limit, int page) async {
    try {
      setState(() {
        isLoading = true; // Mostrar el indicador de carga
      });

      final List<Pokemon> fetchedPokemons =
          await pokemonService.getPokemons(limit, page);

      setState(() {
        pokemons = fetchedPokemons;
        isLoading = false; // Ocultar el indicador de carga
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }
}

class _PokemonsView extends StatelessWidget {
  final List<Pokemon> pokemons;
  final int page;
  const _PokemonsView({required this.pokemons, required this.page});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        
        ...pokemons.map((e) => _PokemonDetailsItem(pokemon: e))
      ],
    );
  }
}

class _PokemonDetailsItem extends ConsumerStatefulWidget {
  const _PokemonDetailsItem({
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  _PokemonDetailsItemState createState() => _PokemonDetailsItemState();
}

class _PokemonDetailsItemState extends ConsumerState<_PokemonDetailsItem> {
  // late Future<PokemonDetails> _pokemonDetailsFuture;

  @override
  void initState() {
    super.initState();
    // _pokemonDetailsFuture = widget.pokemon;
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.pokemon.getId();
    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: colors.primary,
        child: InkWell(
          onTap: () {
            ref
                .read(pokemonNotifierProvider.notifier)
                .addPokemonToFavourite(widget.pokemon);
          },
          child: Column(
            children: [
              Image.network(
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png"),
              Text(
                widget.pokemon.name.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
