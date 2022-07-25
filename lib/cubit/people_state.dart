part of 'people_cubit.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();

  @override
  List<Object> get props => [];
}

class PeopleInitial extends PeopleState {}

class GetPeopleSuccess extends PeopleState {
  final List<People>? getPeople;
  const GetPeopleSuccess({this.getPeople});

  @override
  List<Object> get props => [getPeople ?? []];
}
