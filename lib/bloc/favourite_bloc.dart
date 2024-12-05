import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movie_app/models/movie_data_list.dart';
import 'package:movie_app/models/watchlater.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  List<Result> favoriteMovies = [];
  FavouriteBloc() : super(FavouriteInitial()) {
    on<FavouriteMoviesInitialEvent>(favouriteMoViesInitialEvent);

    on<AddFavouriteEvent>(addFavouriteEvent);

    on<RemoveFavouriteEvent>(removeFavouriteEvent);
  }

  FutureOr<void> favouriteMoViesInitialEvent(
      FavouriteMoviesInitialEvent event, Emitter<FavouriteState> emit) async {
    // print("Favoutite movie added state");
    emit(FavouritePageLoadingState());
    var client = http.Client();
    try {
      http.Response response = await client.get(
        Uri.parse(
            'https://api.themoviedb.org/3/account/21410358/favorite/movies'),
        headers: <String, String>{
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
        },
      ).then(
        (value) {
          // print(value.body);

          WatchLaterDataList result = watchLaterDataListFromJson(value.body);
          if (value.statusCode == 200) {
            emit(FavouriteSuccessState(favouritedata: result.results ?? []));
          }
          // emit(FavouriteSuccessState(favouritedata: result.results ?? []));
          return value;
        },
      ).onError(
        (error, stackTrace) {
          // print('error');
          // print(error.toString());
          // print('error');
          // print(stackTrace.toString());
          throw error.toString();
        },
      );

      // if (response.statusCode == 200) {
      //   var results = jsonDecode(response.body);

      //   print(response.body);
      //   print("favourtite page ....................................");
      //   //  favoriteMovies.add(event.movie);
      //   var movieDataList = MovieDataList.fromJson(results);
      //   emit(AddedFavouriteMovie(data: movieDataList.results ?? []));
      // }
    } catch (e) {
      // print(e.toString());
      emit(FavouriteMovieAddErrorState());
    }
  }

  FutureOr<void> addFavouriteEvent(
      AddFavouriteEvent event, Emitter<FavouriteState> emit) async {
    // print("add to the favourite list.................");
    final Map<String, dynamic> bodydata = {
      "media_type": "movie",
      "media_id": event.favouritemovieID,
      "favorite": true
    };
    final response = await http.post(
        Uri.parse("https://api.themoviedb.org/3/account/21410358/favorite"),
        headers: <String, String>{
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodydata));

    if (response.statusCode == 201) {
      print('added to the FavouritePage');
      add(FavouriteMoviesInitialEvent());
      print(response.body);
      if (!favoriteMovies.any((movie) => movie.id == event.favouritemovieID)) {
        // Ensure no duplicate entries
        favoriteMovies.add(Result(id: event.favouritemovieID));
        // if (favoriteMovies.contains(event.favouritemovieID)) {
        //   favoriteMovies.remove(event.favouritemovieID);
      }
      emit(
          AddedFavouriteSuccessState(favouritedata: List.from(favoriteMovies)));
// favoriteMovies.add(event.movie);
      // emit(AddedFavouriteMovie());
    } else {
      emit(FavouriteMovieAddErrorState());
    }
  }

  FutureOr<void> removeFavouriteEvent(
      RemoveFavouriteEvent event, Emitter<FavouriteState> emit) async {
    final Map<String, dynamic> bodydata = {
      "media_type": "movie",
      "media_id": event.favouritemovieID,
      "favorite": false
    };
    final response = await http.post(
        Uri.parse("https://api.themoviedb.org/3/account/21410358/favorite"),
        headers: <String, String>{
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodydata));
    if (response.statusCode == 200) {
      print('Removed from favourites');
      // Re-fetch the updated list of favorites
      add(FavouriteMoviesInitialEvent());
    } else {
      emit(FavouriteMovieAddErrorState());
    }
  }
}
