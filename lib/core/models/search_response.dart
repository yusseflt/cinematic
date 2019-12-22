import 'dart:convert';

import 'package:cinematic/core/models/movie_model.dart';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  int page;
  int totalResults;
  int totalPages;
  List<Movie> results;

  SearchResponse({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "total_results": totalResults,
        "total_pages": totalPages,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
