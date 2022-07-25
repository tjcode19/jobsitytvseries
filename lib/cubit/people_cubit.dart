import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobsitytvseries/data/repository.dart';
import 'package:jobsitytvseries/data/shared_preference.dart';

import 'base_cubit.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  final Repository? repository;
  final SharedPreferenceApp? sharedPreference;
  final BaseCubit? baseCubit;

  PeopleCubit({this.baseCubit, this.repository, this.sharedPreference})
      : super(PeopleInitial());

  getShows({page = 0}) async {
    // emit(SendMoneyOtherBanks(acctName: ''));

    await repository?.getShows(page).then(
      (apiCall) => {
        if (apiCall.responseCode != '00')
          {
            // emit(DashHomeInitial(status: 'failed'))
          }
        else
          {
            // emit(GetShowSuccess(getShows: apiCall.data))
          }
      },
      onError: (error) {
        // emit(DashHomeInitial(status: 'failed'));
        throw StateError('Get Beneficiary Failed $error');
      },
    );
  }
}
