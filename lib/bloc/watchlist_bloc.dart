import 'dart:async';
import 'dart:convert';

// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movie_app/models/movie_data_list.dart';
import 'package:movie_app/models/watchlater.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

// List<Result> watchlater = [];

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  List<Result> watchlater = [];
  WatchlistBloc() : super(WatchlistInitial()) {
    on<WatchListInitialEvent>(watchListInitialEvent);

    on<AddToWatchlist>(addToWatchlist);

    on<RemoveFromWatchlist>(removeFromWatchlist);

    // on<NavigateWatchListEvent>(navigateWatchListEvent);
  }

  FutureOr<void> watchListInitialEvent(
      WatchListInitialEvent event, Emitter<WatchlistState> emit) async {
    // print('loading state');
    emit(WatchlistLoading());
    var client = http.Client();
    // print('var client...............');
    try {
      http.Response response = await client.get(
        Uri.parse(
            'https://api.themoviedb.org/3/account/21410358/watchlist/movies'),
        headers: <String, String>{
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
        },
      ).then(
        (value) {
          print(value.body);
          WatchLaterDataList result = watchLaterDataListFromJson(value.body);
          // print(result['results']);
          // List<Result> data = result['results'];
          if (value.statusCode == 200) {
            emit(WatchlistSuccessState(watchlater: result.results ?? []));
          }

          print(value.body);
          print('results');
          print(result.results!.length);

          // emit(WatchlistSuccessState(watchlater: result.results ?? []));
          return value;
        },
      ).onError(
        (error, stackTrace) {
          print('error');
          print(error.toString());
          print('error');
          print(stackTrace.toString());
          throw error.toString();
        },
      );
      // if (response.statusCode == 200) {
      //   // print(response.body);
      //   WatchLaterDataList result = watchLaterDataListFromJson(response.body);
      //   // print(result['results']);
      //   // List<Result> data = result['results'];
      //   if (response.statusCode == 200) {
      //     emit(WatchlistSuccessState(watchlater: result.results ?? []));
      //   }

      //   print(response.body);
      //   print('results');
      //   print(result.results!.length);

      //   emit(WatchlistSuccessState(watchlater: result.results ?? []));
      // }
    } catch (e) {
      // print('error');
      // print(e.toString());
      emit(WatchlistFailureState());
    }
  }

  FutureOr<void> addToWatchlist(
      AddToWatchlist event, Emitter<WatchlistState> emit) async {
    final Map<String, dynamic> bodydata = {
      "media_type": "movie",
      "media_id": event.clickedMovieId,
      "watchlist": true
    };

    final response = await http.post(
        Uri.parse('https://api.themoviedb.org/3/account/21410358/watchlist'),
        headers: <String, String>{
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodydata));
    if (response.statusCode == 201) {
      print('added to the Watchlater Page');
      add(WatchListInitialEvent());
      print(response.body);
      if (!watchlater.any((movie) => movie.id == event.clickedMovieId)) {
        // Ensure no duplicate entries
        watchlater.add(Result(id: event.clickedMovieId));
      } else {
        // watchlater.add(event.clickedMovieId);
        print("eeeeeeeeeeeeeeerrrrrrrorrrrrrrr");
      }
      emit(AddedWatchlistSuccessState(watchlater: watchlater));
    } else {
      emit(WatchlistFailureState());
    }
  }

  FutureOr<void> removeFromWatchlist(
      RemoveFromWatchlist event, Emitter<WatchlistState> emit) async {
    final Map<String, dynamic> bodydata = {
      "media_type": "movie",
      "media_id": event.clickedMovieId,
      "watchlist": false
    };
    final response = await http.post(
        Uri.parse('https://api.themoviedb.org/3/account/21410358/watchlist'),
        headers: <String, String>{
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodydata));
    if (response.statusCode == 201) {
      print('added to the Watchlater Page');
      add(WatchListInitialEvent());
      print(response.body);
      if (!watchlater.any((movie) => movie.id == event.clickedMovieId)) {
        // Ensure no duplicate entries
        watchlater.add(Result(id: event.clickedMovieId));
      } else {
        // watchlater.add(event.clickedMovieId);
        print("eeeeeeeeeeeeeeerrrrrrrorrrrrrrr");
      }
      emit(AddedWatchlistSuccessState(watchlater: watchlater));
    } else {
      emit(WatchlistFailureState());
    }
  }
}
