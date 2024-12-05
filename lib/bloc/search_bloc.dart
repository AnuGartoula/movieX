import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_data_list.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchQueryChange>(searchQueryChange);

    on<SearchClear>(searchClear);
  }

  FutureOr<void> searchQueryChange(
      SearchQueryChange event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());

    var client = http.Client();
    try {
      var response = await client.get(

          //essential to add ?query=${event.query}"
          Uri.parse(
              "https://api.themoviedb.org/3/search/movie?query=${event.query}"), // passes the query dynamically
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
          }).then(
        (value) {
          // print("dgf heiufgeui fei fewofegdfbuf wve");
          if (value.statusCode == 200) {
            var result = jsonDecode(value.body);

            // print("json decodeee,,,,,,,,,,,,,");
            // print(value.body);
            var movieDataList = MovieDataList.fromJson(result);
            emit(SearchSuccessState(data: movieDataList.results ?? []));
            // print("heloooooooooooooooooooooooo");
          } else {
            emit(SearchErrorState());
          }
        },
      ).onError(
        (error, stackTrace) {
          // print(error.toString());
          // print('error');
          // print(stackTrace.toString());
        },
      );
    } catch (e) {}
  }

  FutureOr<void> searchClear(SearchClear event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }
}
