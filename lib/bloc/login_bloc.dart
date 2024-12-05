import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<RequestTokenEvent>(requestTokenEvent);

    on<CreateSessionEvent>(createSessionEvent);
  }

  Future<FutureOr<void>> requestTokenEvent(
      RequestTokenEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse('https://api.themoviedb.org/3/authentication/token/new'),
        headers: <String, String>{
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
        },
      ).then((value) async {
        print("requesttttttttttttttttttttttttt ");
        if (value.statusCode == 200) {
          final data = jsonDecode(value.body);
          final requestToken = data['request_token'];
          //shared preferences for storing token

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('request_token', requestToken);

          emit(LoginSuccess(requestToken));
        } else {
          emit(LoginFailure('Login Failed'));
        }
      }).onError(
        (error, stackTrace) {
          print(error.toString());
          print('error 3453435343543534534343534534354353');
          print(stackTrace.toString());
        },
      );
    } catch (e) {
      emit(LoginFailure('Login Failed'));
    }
  }

  FutureOr<void> createSessionEvent(
      CreateSessionEvent event, Emitter<LoginState> emit) async {
    emit(SessionLoadingState());
    var client = http.Client();
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedToken =
          prefs.getString('request_token'); // Retrieve the saved token

      if (savedToken == null) {
        emit(LoginFailure('No token found'));
        return;
      }
      var response = await client.post(
        Uri.parse('https://api.themoviedb.org/3/authentication/session/new'),
        body: jsonEncode({"request_token": event.token}),
        headers: {
          "Content-Type": "application/json",
        },
        // headers: <String, String>{
        //   'Authorization':
        //       'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNGJlZDFkNjA1ZjMzYjkzNWQxZGIyOWNmYWZhMDc1ZSIsIm5iZiI6MTcyMjMxODkzNy45MTM5NzUsInN1YiI6IjY2YTcxZjc5OGI0NjdkZjY0OTA1Y2FlMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hkxmSLLYu_K4tR2ML4g1RzSiMNUa5f48jvuIL9dx2-U',
        // },
      ).then((value) {
        print("SEssssionnnnnnnnnnnnnnnnn ");
        if (value.statusCode == 200) {
          final data = jsonDecode(value.body);
          final sessionId = data['session_id'];
          print("Session ID: $sessionId");
          emit(SessionSucessState(sessionId));
        } else {
          throw Exception('Failed to Create Session');
        }
      }).onError(
        (error, stackTrace) {
          print(error.toString());
          print('error');
          print(stackTrace.toString());
        },
      );
    } catch (e) {
      // emit(LoginFailure('Login Failed'));
    }
  }
}
