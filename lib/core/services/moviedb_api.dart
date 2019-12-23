import 'package:cinematic/core/models/movie_details_model.dart';
import 'package:cinematic/core/models/search_response.dart';
import 'package:cinematic/core/models/service_response.dart';
import 'package:cinematic/ui/values/strings.dart';
import 'package:http/http.dart' as http;

class Api {
  final client = http.Client();

  Future<dynamic> getNowPlaying(int page) async {
    try {
      var response = await client
          .get('$API_URL/movie/now_playing?api_key=$API_KEY&page=$page');

      return serviceResponseFromJson(response.body);
    } catch (e) {
      // print(e);
      return 'Erro';
    }
  }

  Future<dynamic> getPopular(int page) async {
    try {
      var response = await client
          .get('$API_URL/movie/popular?api_key=$API_KEY&page=$page');

      return serviceResponseFromJson(response.body);
    } catch (e) {
      // print(e);
      return 'Erro';
    }
  }

  Future<dynamic> getTopRated(int page) async {
    try {
      var response = await client
          .get('$API_URL/movie/top_rated?api_key=$API_KEY&page=$page');

      return serviceResponseFromJson(response.body);
    } catch (e) {
      // print(e);
      return 'Erro';
    }
  }

  Future<dynamic> getUpcomingMovies(int page) async {
    try {
      var response = await client
          .get('$API_URL/movie/upcoming?api_key=$API_KEY&page=$page');

      return serviceResponseFromJson(response.body);
    } catch (e) {
      // print(e);
      return 'Erro';
    }
  }

  Future<dynamic> getMovieDetails(int id) async {
    try {
      var response = await client.get('$API_URL/movie/$id?api_key=$API_KEY');

      return movieDetailsModelFromJson(response.body);
    } catch (e) {
      // print(e);
      return 'Erro';
    }
  }

  Future<dynamic> searchMovie(String query, int page) async {
    try {
      var response = await client.get(
          '$API_URL/search/movie?api_key=$API_KEY&query=$query&page=$page');

      return searchResponseFromJson(response.body);
    } catch (e) {
      // print(e);
      return 'Erro';
    }
  }
}
