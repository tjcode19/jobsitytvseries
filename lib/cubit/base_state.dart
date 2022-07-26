part of 'base_cubit.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object> get props => [];
}

class BaseInitial extends BaseState {}

class BaseLoaded extends BaseState {
  final bool? isCompleted;

  const BaseLoaded({this.isCompleted});
}

class BaseLoadAnim extends BaseState {
  final bool? isStart;

  const BaseLoadAnim({this.isStart});
}

class Loading extends BaseState {
  final bool? show;

  Loading({this.show});
}

class AppError extends BaseState {
  final bool? show;
  final String? msg;

  AppError({this.msg, this.show});
}

class IsFirstTimer extends BaseState {
  final bool? val;
  const IsFirstTimer({this.val});

  @override
  List<Object> get props => [val??true];
}
