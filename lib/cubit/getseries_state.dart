part of 'getseries_cubit.dart';

abstract class GetseriesState extends Equatable {
  const GetseriesState();

  @override
  List<Object> get props => [];
}

class GetseriesInitial extends GetseriesState {}

class GetShowSuccess extends GetseriesState {
  final List<Data>? getShows;
  const GetShowSuccess({this.getShows});

  @override
  List<Object> get props => [getShows ?? []];
}
