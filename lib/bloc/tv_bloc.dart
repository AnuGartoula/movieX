import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_data_list.dart';
part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  TvBloc() : super(TvInitial()) {
    on<TvInitialEvent>(tvInitialEvent);
  }

  FutureOr<void> tvInitialEvent(
      TvInitialEvent event, Emitter<TvState> emit) async {
    emit(TvLoadingSate());
     var client = http.Client();
        try {
      var response = await client.get(
        Uri.parse(
            'https://api.themoviedb.org/3/discover/tv'),
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
            emit(TvSuccessState(tvdata: movieDataList.results ?? []));
            // print("heloooooooooooooooooooooooo");
          } else {
            emit(TvFailure());
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
      emit(TvFailure());
    }
  }
  }

