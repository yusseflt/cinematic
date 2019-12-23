import 'package:cinematic/core/models/movie_model.dart';
import 'package:cinematic/core/models/search_response.dart';
import 'package:cinematic/core/models/service_response.dart';
import 'package:cinematic/core/services/moviedb_api.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  static HomeViewModel _instance;
  Api _api = Api();

  List<Movie> nowPlayingList = List();
  List<Movie> popularMoviesList = List();
  List<Movie> topRatedList = List();
  List<Movie> upcomingMoviesList = List();

  List<Movie> searchList = List();

  int actualPage = 1;

  bool searching = false;
  bool noMovieFound = false;

  int totalPagesPopular = 0;
  int totalSearchPage = 0;

  HomeViewModel() {
    getNowPlayingMovies(actualPage);
    getPopular(actualPage);
    getTopRated(actualPage);
    getUpcomingMovies(actualPage);
  }

  static HomeViewModel instance() {
    if (_instance == null) {
      _instance = HomeViewModel();
    }
    return _instance;
  }

  Future<void> getNowPlayingMovies(int page) async {
    try {
      var response = await _api.getNowPlaying(page);
      if (response is ServiceResponse) {
        nowPlayingList.addAll(List.generate(
            response.results.length, (index) => response.results[index]));
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> getPopular(int page) async {
    try {
      var response = await _api.getPopular(page);
      if (response is ServiceResponse) {
        popularMoviesList.addAll(List.generate(
            response.results.length, (index) => response.results[index]));

        totalPagesPopular = response.totalPages;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> getTopRated(int page) async {
    try {
      var response = await _api.getTopRated(page);
      if (response is ServiceResponse) {
        topRatedList.addAll(List.generate(
            response.results.length, (index) => response.results[index]));
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> getUpcomingMovies(int page) async {
    try {
      var response = await _api.getUpcomingMovies(page);
      if (response is ServiceResponse) {
        upcomingMoviesList.addAll(List.generate(
            response.results.length, (index) => response.results[index]));
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> searchMovie(String query, int page) async {
    searchList = List();
    try {
      noMovieFound = false;
      searching = true;
      var response = await _api.searchMovie(query, page);

      if (response is SearchResponse) {
        searchList.addAll(List.generate(
            response.results.length, (index) => response.results[index]));
        if (response.totalPages == 0) {
          noMovieFound = true;
        }
        totalSearchPage = response.totalPages;
      }
    } catch (e) {
      print(e);
    }
    searching = false;
    notifyListeners();
  }
}
