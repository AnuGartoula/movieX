import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movie_app/models/movie_data_list.dart';

part 'toprated_event.dart';
part 'toprated_state.dart';

class TopratedBloc extends Bloc<TopratedEvent, TopratedState> {
  TopratedBloc() : super(TopratedInitial()) {
    on<TopRatedMovieIntialEvent>(topRatedMovieIntialEvent);
  }

  FutureOr<void> topRatedMovieIntialEvent(
      TopRatedMovieIntialEvent event, Emitter<TopratedState> emit) async {
    // print("eroooorrr");
    emit(TopRatedMovieLoadingState());
    var client = http.Client();
    try {
      // print('getttttttttttttttttttttttt');
      var response = await client.get(
        Uri.parse("https://api.themoviedb.org/3/movie/top_rated"),
        headers: <String, String>{
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
        },
      ).then(
        (value) {
          if (value.statusCode == 200) {
            var result = jsonDecode(value.body);
            // print(value.body);
            // print("valueeeeeeeeeeeeeeeee");
            var movieDataList = MovieDataList.fromJson(result);
            emit(TopRatedMovieSuccessState(data: movieDataList.results ?? []));
            // print("gfu d vdisfejif");
          } else {
            emit(TopRatedMovieErrorState());
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
      // print(e.toString());
    }
  }
}
