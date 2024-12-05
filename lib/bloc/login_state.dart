part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess(this.token);
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

class SessionSucessState extends LoginState {
  final int sessionId;

  SessionSucessState(this.sessionId);
}

class SessionErrorState extends LoginState {}

class SessionLoadingState extends LoginState {}
