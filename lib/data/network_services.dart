import 'api_provider.dart';

class NetworkService {
  ApiProvider apiProvider = ApiProvider();

  Future<dynamic> getShows(page) async {
    dynamic res;
    try {
      final response = await apiProvider.get('shows?page=$page');
      if (response != []) {
        res = {'responseCode': '00', 'data': response};
      } else {
        res = {'responseCode': '01', 'data': []};
      }
    } catch (e) {
      return {'responseCode': '08', 'responseDescription': 'error dey $e'};
    }
    return res;
  }

  Future<dynamic> getEpisodes(showId) async {
    dynamic res;
    try {
      final response = await apiProvider.get('shows/$showId/episodes');
      if (response != []) {
        res = {'responseCode': '00', 'episodes': response};
      } else {
        res = {'responseCode': '01', 'episodes': []};
      }
    } catch (e) {
      return {'responseCode': '08', 'responseDescription': 'error dey $e'};
    }
    return res;
  }

  Future<dynamic> getPeople(page) async {
    dynamic res;
    try {
      final response = await apiProvider.get('people?page=$page');
      if (response != []) {
        res = {'responseCode': '00', 'people': response};
      } else {
        res = {'responseCode': '01', 'people': []};
      }
    } catch (e) {
      return {'responseCode': '08', 'responseDescription': 'error dey $e'};
    }
    return res;
  }
}
