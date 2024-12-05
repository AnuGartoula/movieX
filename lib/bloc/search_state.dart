part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}
final class SearchLoadingState extends SearchState {}
final class SearchSuccessState extends SearchState {
  
   final List<Result> data;

  SearchSuccessState({required this.data});
}
final class SearchErrorState extends SearchState {}
