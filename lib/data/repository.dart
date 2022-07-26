import 'dart:developer';

import 'package:jobsitytvseries/data/models/get_featured_series.dart';
import 'package:jobsitytvseries/data/models/get_shows.dart';

import 'models/get_episodes.dart';
import 'models/get_people.dart';
import 'network_services.dart';

class Repository {
  final NetworkService? networkService;

  Repository({this.networkService});

  Future<bool> finishSplashScreen() async {
    return false;
  }

  Future<GetShowModel> getShows(page) async {
    final response = await networkService?.getShows(page);

    // log(response.toString());

    // List<GetShowModel> _listProducts = [];
    // if (response != null) {
    //   for (var item in response) {
    //     _listProducts.add(GetShowModel.fromJson(item));
    //   }
    // }

    // inspect(_listProducts);



    // log(_listProducts.toString());

    return GetShowModel.fromJson(response);
  }

  Future<GetEpisodesModel> getEpisodes(showId) async {
    final response = await networkService?.getEpisodes(showId);

    return GetEpisodesModel.fromJson(response);
  }

  Future<GetPeopleModel> getPeople(page) async {
    final response = await networkService?.getPeople(page);

    return GetPeopleModel.fromJson(response);
  }

  Future<GetFeatureSeriesModel> getFeaturedSeries(personId) async {
    final response = await networkService?.getFeaturedSeries(personId);

    return GetFeatureSeriesModel.fromJson(response);
  }
}
