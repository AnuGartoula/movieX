part of 'watchlist_bloc.dart';

@immutable
sealed class WatchlistEvent {}

class WatchListInitialEvent extends WatchlistEvent {}

final class AddToWatchlist extends WatchlistEvent {
  final int clickedMovieId;

  AddToWatchlist({required this.clickedMovieId});
}

class RemoveFromWatchlist extends WatchlistEvent {
  final int clickedMovieId;

  RemoveFromWatchlist({required this.clickedMovieId});
}
