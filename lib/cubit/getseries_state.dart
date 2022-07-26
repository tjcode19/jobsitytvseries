part of 'getseries_cubit.dart';

abstract class GetseriesState extends Equatable {
  const GetseriesState();

  @override
  List<Object> get props => [];
}

class GetseriesInitial extends GetseriesState {}

class GetShowSuccess extends GetseriesState {
  final List<Data>? getShows;
  final Set<int>? favs;
  final bool? isLoading;
  const GetShowSuccess({this.getShows, this.favs, this.isLoading});

  @override
  List<Object> get props => [getShows ?? [], favs ?? [], isLoading ?? false];
}

class GetEpisodesSuccess extends GetseriesState {
  final List<Episodes>? getEpisodes;
  const GetEpisodesSuccess({this.getEpisodes});

  @override
  List<Object> get props => [getEpisodes ?? []];
}
