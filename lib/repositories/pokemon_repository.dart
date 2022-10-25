import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_test/pages/pokemon_page_response.dart';

import '../models/pokemon_info_response.dart';
import '../models/pokemon_species_info_response.dart';

class PokemonRepository {
  final baseUrl = 'pokeapi.co';
  //Dependency injections
  final client = http.Client();

  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async {
    // pokemon?limit=200^offset=400
    final queryParameters = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };
    final uri = Uri.https(baseUrl, 'api/v2/pokemon/', queryParameters);
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return PokemonPageResponse.fromJson(json);
  }

  Future<PokemonInfoResponse> getPokemonInfo(int pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon/$pokemonId');

    // try {
    //   final response = await client.get(uri);
    //   final json = jsonDecode(response.body);
    //   return PokemonInfoResponse.fromJson(json);
    // } catch (e) {
    //   print(e);
    // }
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return PokemonInfoResponse.fromJson(json);
  }

  Future<PokemonSpeciesInfoResponse> getPokemonSpeciesInfo(
      int pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon-species/$pokemonId');
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return PokemonSpeciesInfoResponse.fromJson(json);
    // try {

    // } catch (e) {
    //   print(e);
    // }
  }
}
