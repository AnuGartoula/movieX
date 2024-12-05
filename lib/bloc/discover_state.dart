part of 'discover_bloc.dart';

@immutable
sealed class DiscoverState {}

final class DiscoverInitial extends DiscoverState {}

class DiscoverLoadingState extends DiscoverState{}
class DiscoverSucessState extends DiscoverState{

   final List<Result> data;

  DiscoverSucessState({required this.data});
}
class DiscoverErrorState extends DiscoverState{}