import 'package:jobsitytvseries/data/models/get_shows.dart';

import 'network_services.dart';

class Repository {
  final NetworkService? networkService;

  Repository({this.networkService});

  Future<bool> finishSplashScreen() async {
    return false;
  }

  Future<GetShowModel> getSavedBeneficiaries() async {
    final response = await networkService?.getShows();

    return GetShowModel.fromJson(response);
  }
}
