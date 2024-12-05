part of 'toprated_bloc.dart';

@immutable
sealed class TopratedState {}

final class TopratedInitial extends TopratedState {}

class TopRatedMovieLoadingState extends TopratedState {}

class TopRatedMovieSuccessState extends TopratedState {
  final List<Result> data;

  TopRatedMovieSuccessState({required this.data});
}

class TopRatedMovieErrorState extends TopratedState {}
