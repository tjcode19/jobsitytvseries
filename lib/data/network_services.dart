import 'api_provider.dart';

class NetworkService {
  ApiProvider apiProvider = ApiProvider();

  Future<dynamic> getShows() async {
    Map<String, dynamic> res;
    try {
      final response = await apiProvider.get('shows');
      res = response;
    } catch (e) {
      return {'responseCode': '08', 'responseDescription': 'error dey $e'};
    }
    return res;
  }
}
