import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobsitytvseries/data/models/get_featured_series.dart';
import 'package:jobsitytvseries/data/models/get_people.dart';
import 'package:jobsitytvseries/data/repository.dart';
import 'package:jobsitytvseries/data/shared_preference.dart';
import 'package:jobsitytvseries/presentation/screens/show_details.dart';

import 'base_cubit.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  final Repository? repository;
  final SharedPreferenceApp? sharedPreference;
  final BaseCubit? baseCubit;

  PeopleCubit({this.baseCubit, this.repository, this.sharedPreference})
      : super(PeopleInitial());

  getPeople({page = 0}) async {
    await repository?.getPeople(page).then(
      (apiCall) => {
        if (apiCall.responseCode != '00')
          {
            
          }
        else
          {
            emit(GetPeopleSuccess(getPeople: apiCall.people))
          }
      },
      onError: (error) {
        throw StateError('Get People Failed $error');
      },
    );
  }

  getFeaturesSeries({personId}) async {
    await repository?.getFeaturedSeries(personId).then(
      (apiCall) => {
        if (apiCall.responseCode != '00')
          {
          }
        else
          {
            emit(GetFeaturedSuccess(featuredShows: apiCall.showsDetails))
          }
      },
      onError: (error) {
        throw StateError('Get Features Series Failed $error');
      },
    );
  }
}
