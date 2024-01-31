import 'package:flutter/material.dart';
import 'package:poekapi_app/presentation/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokemons'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
        drawer: const Drawer(
          child: PokemonFavScreen(),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPage,
          onDestinationSelected: (value) {
            currentPage = value;
            setState(() {});
          },
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.abc), label: 'Pokemons'),
            NavigationDestination(icon: Icon(Icons.star), label: 'Favourites'),
          ],
        ),
        body: IndexedStack(
          index: currentPage,
          children: const <Widget>[
            // Pokemons
            PokemonsScreen(),
            // Favs
            PokemonFavScreen()
          ],
        ));
  }
}
