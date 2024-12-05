part of 'tv_bloc.dart';

@immutable
sealed class TvState {}

final class TvInitial extends TvState {}
final class TvLoadingSate extends TvState {}
final class TvSuccessState extends TvState {
    final List<Result> tvdata;

  TvSuccessState({required this.tvdata});
}
final class TvFailure extends TvState {}
