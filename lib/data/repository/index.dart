import '../network_services.dart';

class Repository {
  final NetworkService? networkService;

  Repository({this.networkService});

  Future<bool> finishSplashScreen() async {
    return false;
  }
  }