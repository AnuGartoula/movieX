part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchQueryChange extends SearchEvent {
  // search queriesss
  final String query;

  SearchQueryChange(this.query);
}

 class SearchClear extends SearchEvent{}
