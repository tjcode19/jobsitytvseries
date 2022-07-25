import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobsitytvseries/data/models/get_people.dart';
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

  getPeople({page = 0}) async {
    // emit(SendMoneyOtherBanks(acctName: ''));

    await repository?.getPeople(page).then(
      (apiCall) => {
        if (apiCall.responseCode != '00')
          {
            // emit(DashHomeInitial(status: 'failed'))
          }
        else
          {
            emit(GetPeopleSuccess(getPeople: apiCall.people))
          }
      },
      onError: (error) {
        // emit(DashHomeInitial(status: 'failed'));
        throw StateError('Get Beneficiary Failed $error');
      },
    );
  }
}
