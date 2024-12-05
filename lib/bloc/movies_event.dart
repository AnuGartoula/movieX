part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

class MovieInitialEvent extends MoviesEvent {}

// class FavouriteButtonclickedEvent extends MoviesEvent {
//   final Result clickedMovie;

//   FavouriteButtonclickedEvent({required this.clickedMovie});
// }

class AddFavouriteMovie extends MoviesEvent {
   final Result movie;

  AddFavouriteMovie({required this.movie});
}

class NavigatetoFavouriteEvent extends MoviesEvent {}
