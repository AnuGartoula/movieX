part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {
  get data => null;
}

final class MoviesInitial extends MoviesState {}

//fetching States
class MovieLoadingState extends MoviesState {}

class MovieFetchingSuccessState extends MoviesState {
  final List<Result> data;

  MovieFetchingSuccessState({required this.data});
}

class MovieFetchingErrorState extends MoviesState {}

class FavouriteMovieAddErrorState extends MoviesState {}




//favourite page
// class FavouritePageState extends MoviesState {
//    final List<Result> data;

//   FavouritePageState({required this.data});
// }

// class FavouritePageLoadingState extends MoviesState {}
// class AddedFavouriteMovie extends MoviesState {}


// class FavouritesPageState extends MoviesState {
// final List<Result> favoriteMovies;
// FavouritesPageState({required this.favoriteMovies});
// }

//all movies fetching state
// class AllMoviesFetchingState extends MoviesState {}
