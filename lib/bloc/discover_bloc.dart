import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movie_app/models/movie_data_list.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(DiscoverInitial()) {
    on<DiscoverInitialEvent>(discoverInitialEvent);
  }

  FutureOr<void> discoverInitialEvent(
    
      DiscoverInitialEvent event, Emitter<DiscoverState> emit) async {
    emit(DiscoverLoadingState());

    var client = http.Client();
    try {
      var response = await client.get(
          Uri.parse("https://api.themoviedb.org/3/discover/movie?"),
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
          }).then(
        (value) {
          // print("dgf heiufgeui fei fewofegdfbuf wve");
          if (value.statusCode == 200) {
            var result = jsonDecode(value.body);

            // print("json decodeee,,,,,,,,,,,,,");
            print(value.body);
            var movieDataList = MovieDataList.fromJson(result);
            emit(DiscoverSucessState(data: movieDataList.results ?? []));
            // print("heloooooooooooooooooooooooo");
          } else {
            emit(DiscoverErrorState());
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
}
