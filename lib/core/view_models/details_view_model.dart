import 'package:cinematic/core/models/movie_details_model.dart';
import 'package:cinematic/core/models/movie_model.dart';
import 'package:cinematic/core/services/moviedb_api.dart';
import 'package:flutter/cupertino.dart';

class DetailsViewModel extends ChangeNotifier {
  MovieDetailsModel movieDetails;
  Api _api = Api();

  DetailsViewModel(Movie movie) {
    getMovieDetails(movie);
  }

  Future<void> getMovieDetails(Movie movie) async {
    try {
      var response = await _api.getMovieDetails(movie.id);

      if (response is MovieDetailsModel) {
        movieDetails = response;
      }
    } catch (e) {
      print(e);
      return 'Erro';
    }
    notifyListeners();
  }

  String formatStringGroups(List group) {
    String finalFormat = '';
    for (int i = 0; i < group.length; i++) {
      var item = group[i];
      if (i == group.length - 1) {
        finalFormat += ' ${item.name}.';
      } else {
        finalFormat += ' ${item.name},';
      }
    }
    return finalFormat;
  }
}
