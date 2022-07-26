import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobsitytvseries/cubit/base_cubit.dart';
import 'package:jobsitytvseries/data/models/get_episodes.dart';
import 'package:jobsitytvseries/data/models/get_shows.dart';
import 'package:jobsitytvseries/data/repository.dart';
import 'package:jobsitytvseries/data/shared_preference.dart';
import '/constants/enums.dart';

part 'getseries_state.dart';

class GetseriesCubit extends Cubit<GetseriesState> {
  final Repository? repository;
  final SharedPreferenceApp? sharedPreference;
  final BaseCubit? baseCubit;

  GetseriesCubit({this.repository, this.sharedPreference, this.baseCubit})
      : super(GetseriesInitial());

  getShows({page = 0}) async {
    emit(const GetShowSuccess(isLoading: true));
    var d = await getIdOfFavShows();

    await repository?.getShows(page).then(
      (apiCall) => {
        if (apiCall.responseCode != '00')
          {}
        else
          {
            emit(GetShowSuccess(
                getShows: apiCall.data, favs: d, isLoading: false))
          }
      },
      onError: (error) {
        throw StateError('Get Beneficiary Failed $error');
      },
    );
  }

  getIdOfFavShows() async {
    List<Data> saveFavShows = await (getFavouriteShows() ?? []);
    Set<int>? favID = {};

    for (var element in saveFavShows) {
      favID.add(element.id!);
    }

    return favID;
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
          {emit(GetEpisodesSuccess(getEpisodes: apiCall.episodes))}
      },
      onError: (error) {
        // emit(DashHomeInitial(status: 'failed'));
        throw StateError('Get Episodes Failed $error');
      },
    );
  }

  savefav({data}) async {
    List<Data> saveFavShows = await (getFavouriteShows() ?? []);

    saveFavShows.add(data);
    sharedPreference!.setData(
        sharedType: spDataType.object,
        fieldName: 'favShows',
        fieldValue: saveFavShows);

    var d = await getIdOfFavShows();

    emit(UpdateFav(favs: d));
  }

  deletefav({Data? data}) async {
    List<Data>? saveFavShows = await (getFavouriteShows() ?? []);
    saveFavShows!.removeWhere((item) => item.id == data!.id);
    sharedPreference!.setData(
        sharedType: spDataType.object,
        fieldName: 'favShows',
        fieldValue: saveFavShows);

    var d = await getIdOfFavShows();

    emit(UpdateFav(favs: d));
  }

  favShows() async {
    List<Data>? saveFavShows = await (getFavouriteShows() ?? []);
    saveFavShows!.sort((a, b) => a.name!.compareTo(b.name!));
    var d = await getIdOfFavShows();

    emit(GetShowSuccess(getShows: saveFavShows, favs: d));
  }

  getFavouriteShows() async {
    List<Data> favShow = [];
    final res;

    try {
      res = await sharedPreference!.getSharedPrefs(
              sharedType: spDataType.object, fieldName: 'favShows') ??
          [];

      List<Data> _favList = [];
      if (res != []) {
        for (var item in res) {
          _favList.add(Data.fromJson(item));
        }
      }

      favShow = _favList;

      log(favShow.toString());
    } catch (e) {
      print(e);
    }
    return favShow;
  }
}
