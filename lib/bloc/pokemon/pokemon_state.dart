part of 'pokemon_bloc.dart';

class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoadInProgress extends PokemonState {}

class PokemonLoadPageSuccess extends PokemonState {
  final List<PokemonListingModel> pokemonListings;
  final bool canLoadNextPage;
  PokemonLoadPageSuccess(
      {required this.pokemonListings, required this.canLoadNextPage});
}

class PokemonPageLoadFailed extends PokemonState {
  final dynamic error;
  PokemonPageLoadFailed({required this.error});
}
