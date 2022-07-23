import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'getseries_state.dart';

class GetseriesCubit extends Cubit<GetseriesState> {
  GetseriesCubit() : super(GetseriesInitial());
}
