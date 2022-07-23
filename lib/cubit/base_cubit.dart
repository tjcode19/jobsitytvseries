import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/data/repository/index.dart';
import '/data/shared_preference.dart';

part 'base_state.dart';

class BaseCubit extends Cubit<BaseState> {
  final Repository? repository;
  final SharedPreferenceApp? sharedPreference;

  BaseCubit({this.repository, this.sharedPreference}) : super(BaseInitial());
}
