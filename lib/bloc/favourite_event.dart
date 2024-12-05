// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favourite_bloc.dart';

@immutable
sealed class FavouriteEvent {}

class FavouriteMoviesInitialEvent extends FavouriteEvent {}

class AddFavouriteEvent extends FavouriteEvent {
  
  final int favouritemovieID;
  AddFavouriteEvent({
    required this.favouritemovieID,
  });

}
class RemoveFavouriteEvent extends FavouriteEvent {
  
  final int favouritemovieID;
  RemoveFavouriteEvent({
    required this.favouritemovieID,
  });

}



