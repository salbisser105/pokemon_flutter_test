import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon_test/models/pokemon_listing_model.dart';
import 'package:pokemon_test/repositories/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRepository = PokemonRepository();
  PokemonBloc() : super(PokemonInitial());

  ///TODO adapt to the latest version of bloc
  // {
  //   on<PokemonPageRequest>(_pokemonRun);
  // }

  // Stream<void> _pokemonRun(
  //     PokemonPageRequest event, Emitter<PokemonState> emit) async* {
  //   yield PokemonLoadInProgress();
  //   try {
  //     final pokemonPageResponse =
  //         await _pokemonRepository.getPokemonPage(event.page);

  //     yield PokemonLoadPageSuccess(
  //         pokemonListings: pokemonPageResponse.pokemonListings,
  //         canLoadNextPage: pokemonPageResponse.canLoadNextPage);
  //   } catch (e) {
  //     yield PokemonPageLoadFailed(error: e);
  //   }
  // }
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is PokemonPageRequest) {
      yield PokemonLoadInProgress();
      try {
        final pokemonPageResponse =
            await _pokemonRepository.getPokemonPage(event.page);
        yield PokemonLoadPageSuccess(
            pokemonListings: pokemonPageResponse.pokemonListings,
            canLoadNextPage: pokemonPageResponse.canLoadNextPage);
      } catch (e) {
        yield PokemonPageLoadFailed(error: e);
      }
    }
  }
}
  
// }
