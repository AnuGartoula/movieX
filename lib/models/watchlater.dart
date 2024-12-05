// To parse this JSON data, do
//
//     final watchLaterDataList = watchLaterDataListFromJson(jsonString);

import 'dart:convert';

import 'package:movie_app/models/movie_data_list.dart';

WatchLaterDataList watchLaterDataListFromJson(String str) =>
    WatchLaterDataList.fromJson(json.decode(str));

String watchLaterDataListToJson(WatchLaterDataList data) =>
    json.encode(data.toJson());

class WatchLaterDataList {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  WatchLaterDataList({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory WatchLaterDataList.fromJson(Map<String, dynamic> json) =>
      WatchLaterDataList(
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
