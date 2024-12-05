part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class RequestTokenEvent extends LoginEvent {
  final String email;
  final String password;

  RequestTokenEvent({required this.email, required this.password});
}

class CreateSessionEvent extends LoginEvent {
   final String token; 
  CreateSessionEvent(this.token);
}
