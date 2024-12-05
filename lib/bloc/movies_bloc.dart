import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movie_app/models/movie_data_list.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  // List<Result> favoriteMovies = [];
  MoviesBloc() : super(MoviesInitial()) {
    on<MovieInitialEvent>(movieInitialEvent);

    on<AddFavouriteMovie>(addFavouriteMovie);

    // on<FavouriteMoviesInitialEvent>(favouriteMoViesInitialEvent);

    // on<NavigatetoFavouriteEvent>(navigatetoFavouriteEvent0);
  }

  FutureOr<void> movieInitialEvent(
      MovieInitialEvent event, Emitter<MoviesState> emit) async {
    emit(MovieLoadingState());
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse(
            'https://api.themoviedb.org/3/trending/all/day?language=en-US'),
        headers: <String, String>{
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
        },
      ).then(
        (value) {
          print("movies detching,............................");
          if (value.statusCode == 200) {
            var result = jsonDecode(value.body);
            // print("json decodeee,,,,,,,,,,,,,");
            print(value.body);
            var movieDataList = MovieDataList.fromJson(result);
            emit(MovieFetchingSuccessState(data: movieDataList.results ?? []));
            // print("heloooooooooooooooooooooooo");
          } else {
            emit(MovieFetchingErrorState());
          }
        },
      ).onError(
        (error, stackTrace) {
          // print(error.toString());
          // print('error');
          // print(stackTrace.toString());
        },
      );
    } catch (e) {
      emit(MovieFetchingErrorState());
    }
  }

  FutureOr<void> addFavouriteMovie(
      AddFavouriteMovie event, Emitter<MoviesState> emit) async {
    // print("add to the favourite list.................");
    final Map<String, dynamic> bodydata = {
      "media_type": "movie",
      "media_id": 550,
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
      // print('added to the FavouritePage');
      // print(response.body);

// favoriteMovies.add(event.movie);
      // emit(AddedFavouriteMovie());
    } else {
      emit(FavouriteMovieAddErrorState());
    }
  }

  // FutureOr<void> favouriteMoViesInitialEvent(
  //     FavouriteMoviesInitialEvent event, Emitter<MoviesState> emit) async {
  // print("Favoutite movie added state");
  // emit(FavouritePageLoadingState());
  // var client = http.Client();
  // try {
  //   var response = await client.get(
  //     Uri.parse(
  //         'https://api.themoviedb.org/3/account/21410358/favorite/movies'),
  //     headers: <String, String>{
  //       'Authorization':
  //           'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     var result = jsonDecode(response.body);

  //     print(response.body);
  //     print("favourtite page ....................................");
  //     var movieDataList = MovieDataList.fromMap(result);
  //     emit(AddedFavouriteMovie());
  //   } else {
  //     emit(FavouriteMovieAddErrorState());
  //   }
  // } catch (e) {
  //   print("error of favourite ");
  //   emit(FavouriteMovieAddErrorState());
  //   }
  // }

  // FutureOr<void> navigatetoFavouriteEvent0(
  //     NavigatetoFavouriteEvent event, Emitter<MoviesState> emit) async {
  //   emit(FavouritesPageState(favoriteMovies: favoriteMovies));
  // }
}
