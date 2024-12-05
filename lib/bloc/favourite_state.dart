part of 'favourite_bloc.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

class FavouritePageLoadingState extends FavouriteState {}

class FavouriteMovieAddErrorState extends FavouriteState {}

class FavouriteSuccessState extends FavouriteState {
  final List<Result> favouritedata;

  FavouriteSuccessState({required this.favouritedata});
}

class AddedFavouriteSuccessState extends FavouriteState {
  final List<Result> favouritedata;

  AddedFavouriteSuccessState({required this.favouritedata});
}
