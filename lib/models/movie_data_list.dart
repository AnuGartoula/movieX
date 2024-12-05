// To parse this JSON data, do
//
//     final movieDataList = movieDataListFromJson(jsonString);

import 'dart:convert';

MovieDataList movieDataListFromJson(String str) =>
    MovieDataList.fromJson(json.decode(str));

String movieDataListToJson(MovieDataList data) => json.encode(data.toJson());

class MovieDataList {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  MovieDataList({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieDataList.fromJson(Map<String, dynamic> json) => MovieDataList(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  // String? backdropPath;
  int? id;
  String? title;
  // String? originalTitle;
  String? overview;
  String? posterPath;
  // String mediaType;
  // bool? adult;
  // String? originalLanguage;
  List<int>? genreIds;
  // double? popularity;
  // // DateTime releaseDate;
  // // bool? video;
  // double voteAverage;
  dynamic voteCount;
  // String name;
  // String? originalName;
  // DateTime? firstAirDate;
  // List<String> originCountry;

  Result({
    // this.backdropPath,
    this.id,
    this.title,
    // this.originalTitle,
    this.overview,
    this.posterPath,
    // this.mediaType = '',
    // this.adult,
    // this.originalLanguage,
    this.genreIds,
    // this.popularity,
    // this.releaseDate = DateTime.,
    // this.video,
    // this.voteAverage = 0.0,
    this.voteCount,
    // this.name = '',
    // this.originalName,
    // this.firstAirDate,
    // this.originCountry = '',
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        // backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        // originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        // mediaType: json["media_type"],
        // adult: json["adult"],
        // originalLanguage: json["original_language"],
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        // popularity: json["popularity"]?.toDouble(),
        // releaseDate: json["release_date"] ,
        // == null
        //     ? null
        //     : DateTime.parse(json["release_date"]),
        // video: json["video"],
        // voteAverage: json["vote_average"],
       voteCount: json["vote_count"],
        // name: json["name"],
        // originalName: json["original_name"],
        // firstAirDate: json["first_air_date"] == null
        // ? null
        // : DateTime.parse(json["first_air_date"]),
        // originCountry: json['origin_country'],
        // originCountry: json["origin_country"] == null
        //     ? []
        //     : List<String>.from(json["origin_country"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        // "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        // "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        // "media_type": mediaTypeValues.reverse[mediaType],
        // "adult": adult,
        // "original_language": originalLanguage,
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        // "popularity": popularity,
        // "release_date":
        //     "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        // "video": video,
        // "vote_average": voteAverage,
         "vote_count": voteCount,
        // "name": name,
        // "original_name": originalName,
        // "first_air_date":
        // "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        // 'origin_country': originCountry
        // "origin_country": originCountry == null
        //     ? []
        //     : List<dynamic>.from(originCountry!.map((x) => x)),
      };
}

enum MediaType { MOVIE, TV }

final mediaTypeValues =
    EnumValues({"movie": MediaType.MOVIE, "tv": MediaType.TV});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
