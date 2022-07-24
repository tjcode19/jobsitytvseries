import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsitytvseries/presentation/screens/authoriser.dart';
import 'package:jobsitytvseries/presentation/screens/main_page.dart';
import '/constants/strings.dart';
import '/cubit/base_cubit.dart';
import '/data/network_services.dart';
import '/data/repository/index.dart';
import '/data/shared_preference.dart';
import '/utils/animations.dart';
import 'screens/splash_screen.dart';

class AppRouter {
  Repository? repository;
  SharedPreferenceApp? sharedPreferenceApp;
  BaseCubit? baseCubit;

  AppRouter() {
    repository = Repository(networkService: NetworkService());
    sharedPreferenceApp = SharedPreferenceApp();
    baseCubit = BaseCubit(
        repository: repository, sharedPreference: sharedPreferenceApp);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BaseCubit(
                repository: repository, sharedPreference: sharedPreferenceApp),
            child: const SplashScreen(),
          ),
        );
      case scrAuthoriser:
        return SlideRightRoute(
          page: BlocProvider(
            create: (BuildContext context) => BaseCubit(
                repository: repository, sharedPreference: sharedPreferenceApp),
            child: const Authoriser(),
          ),
        );
        case scrMainPage:
        return SlideRightRoute(
          page: BlocProvider(
            create: (BuildContext context) => BaseCubit(
                repository: repository, sharedPreference: sharedPreferenceApp),
            child: const MainPage(),
          ),
        );
    }
  }
}
