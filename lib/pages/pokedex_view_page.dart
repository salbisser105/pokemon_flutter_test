import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/models/pokemon_info_response.dart';
import 'package:pokemon_test/models/pokemon_species_info_response.dart';
import 'package:pokemon_test/pages/pokemon_details_page.dart';
import 'package:pokemon_test/repositories/pokemon_repository.dart';

import '../bloc/pokemon/pokemon_bloc.dart';

class PokeDexViewPage extends StatefulWidget {
  const PokeDexViewPage({super.key, required this.title});

  final String title;

  @override
  State<PokeDexViewPage> createState() => _PokeDexViewPageState();
}

class _PokeDexViewPageState extends State<PokeDexViewPage> {
  PokemonRepository pokemonRepository = PokemonRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PokemonLoadPageSuccess) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: state.pokemonListings.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      PokemonInfoResponse pokemon = await pokemonRepository
                          .getPokemonInfo(state.pokemonListings[index].id);
                      PokemonSpeciesInfoResponse pokemonSpeciesInfoResponse =
                          await pokemonRepository.getPokemonSpeciesInfo(
                              state.pokemonListings[index].id);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => PokemonDetailsView(
                            description: pokemonSpeciesInfoResponse.description,
                            height: pokemon.height.toDouble(),
                            id: pokemon.id,
                            imageUrl: pokemon.imageUrl,
                            name: pokemon.name,
                            types: pokemon.types,
                            weight: pokemon.weight.toDouble(),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: GridTile(
                        child: Column(
                          children: [
                            Image.network(
                                state.pokemonListings[index].imageUrl),
                            Text(state.pokemonListings[index].name)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is PokemonPageLoadFailed) {
              return Center(
                child: Text(state.error.toString()),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
