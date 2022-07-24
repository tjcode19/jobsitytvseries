import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobsitytvseries/cubit/base_cubit.dart';
import 'package:jobsitytvseries/data/models/get_episodes.dart';
import 'package:jobsitytvseries/data/models/get_shows.dart';
import 'package:jobsitytvseries/data/repository.dart';
import 'package:jobsitytvseries/data/shared_preference.dart';

part 'getseries_state.dart';

class GetseriesCubit extends Cubit<GetseriesState> {
   final Repository? repository;
  final SharedPreferenceApp? sharedPreference;
  final BaseCubit? baseCubit;

  GetseriesCubit({this.repository, this.sharedPreference, this.baseCubit}) : super(GetseriesInitial());

  getShows({page =1}) async {
    // emit(SendMoneyOtherBanks(acctName: ''));

    await repository?.getShows(page).then(
      (apiCall) => {
        if (apiCall.responseCode != '00')
          {
            // emit(DashHomeInitial(status: 'failed'))
          }
        else
          {
            emit(GetShowSuccess(getShows: apiCall.data))}
      },
      onError: (error) {
        // emit(DashHomeInitial(status: 'failed'));
        throw StateError('Get Beneficiary Failed $error');
      },
    );
  }

  getEpisodes(showId) async {
    // emit(SendMoneyOtherBanks(acctName: ''));

    await repository?.getEpisodes(showId).then(
      (apiCall) => {
        if (apiCall.responseCode != '00')
          {
            // emit(DashHomeInitial(status: 'failed'))
          }
        else
          {
            emit(GetEpisodesSuccess(getEpisodes: apiCall.episodes))}
      },
      onError: (error) {
        // emit(DashHomeInitial(status: 'failed'));
        throw StateError('Get Episodes Failed $error');
      },
    );
  }
}
