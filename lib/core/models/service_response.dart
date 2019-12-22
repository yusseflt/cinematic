import 'dart:convert';

import 'package:cinematic/core/models/movie_model.dart';

ServiceResponse serviceResponseFromJson(String str) =>
    ServiceResponse.fromJson(json.decode(str));

String serviceResponseToJson(ServiceResponse data) =>
    json.encode(data.toJson());

class ServiceResponse {
  List<dynamic> results;
  int page;
  int totalResults;
  Dates dates;
  int totalPages;

  ServiceResponse({
    this.results,
    this.page,
    this.totalResults,
    this.dates,
    this.totalPages,
  });
  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      ServiceResponse(
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        page: json["page"],
        totalResults: json["total_results"],
        dates: Dates.fromJson(json["dates"]) ?? null,
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x)),
        "page": page,
        "total_results": totalResults,
        "dates": dates.toJson() ?? null,
        "total_pages": totalPages,
      };
}

class Dates {
  DateTime maximum;
  DateTime minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: json == null ? null : DateTime.parse(json["maximum"]),
        minimum: json == null ? null : DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
