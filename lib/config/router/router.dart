import 'package:go_router/go_router.dart';
import 'package:poekapi_app/presentation/screens/screens.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/pokemon/:pokemonId',
    builder: (context, state) =>  PokemonDetailsScreen(pokemonId: state.pathParameters['pokemonId']!),
  ),
]);
