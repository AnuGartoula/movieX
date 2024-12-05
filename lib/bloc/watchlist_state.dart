part of 'watchlist_bloc.dart';

@immutable
sealed class WatchlistState {}

final class WatchlistInitial extends WatchlistState {}

final class WatchlistLoading extends WatchlistState {}

final class WatchlistSuccessState extends WatchlistState {
  final List<Result> watchlater;

  WatchlistSuccessState({required this.watchlater});
}

final class WatchlistFailureState extends WatchlistState {}

final class AddedWatchlistSuccessState extends WatchlistState {
  final List<Result> watchlater;

  AddedWatchlistSuccessState({required this.watchlater});
}
