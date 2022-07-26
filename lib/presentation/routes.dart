import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsitytvseries/cubit/getseries_cubit.dart';
import 'package:jobsitytvseries/cubit/people_cubit.dart';
import 'package:jobsitytvseries/data/models/get_episodes.dart';
import 'package:jobsitytvseries/data/models/get_people.dart';
import 'package:jobsitytvseries/data/models/get_shows.dart';
import 'package:jobsitytvseries/presentation/screens/authoriser.dart';
import 'package:jobsitytvseries/presentation/screens/favourite_shows.dart';
import 'package:jobsitytvseries/presentation/screens/main_page.dart';
import 'package:jobsitytvseries/presentation/screens/people_screen.dart';
import 'package:jobsitytvseries/presentation/screens/show_details.dart';
import '/constants/strings.dart';
import '/cubit/base_cubit.dart';
import '/data/network_services.dart';
import '../data/repository.dart';
import '/data/shared_preference.dart';
import '/utils/animations.dart';
import 'screens/episode_details.dart';
import 'screens/people_details.dart';
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
          page: MultiBlocProvider(
            providers: [
              BlocProvider<BaseCubit>(
                lazy: false,
                create: (BuildContext context) => BaseCubit(
                    repository: repository,
                    sharedPreference: sharedPreferenceApp),
              ),
              BlocProvider<GetseriesCubit>(
                create: (BuildContext context) => GetseriesCubit(
                  repository: repository,
                  sharedPreference: sharedPreferenceApp,
                  baseCubit: baseCubit,
                ),
              ),
              BlocProvider<PeopleCubit>(
                create: (BuildContext context) => PeopleCubit(
                  repository: repository,
                  sharedPreference: sharedPreferenceApp,
                  baseCubit: baseCubit,
                ),
              ),
            ],
            child: const MainPage(),
          ),
        );

      case scrFavouriteShow:
        return SlideRightRoute(
          page: MultiBlocProvider(
            providers: [
              BlocProvider<BaseCubit>(
                lazy: false,
                create: (BuildContext context) => BaseCubit(
                    repository: repository,
                    sharedPreference: sharedPreferenceApp),
              ),
              BlocProvider<GetseriesCubit>(
                create: (BuildContext context) => GetseriesCubit(
                  repository: repository,
                  sharedPreference: sharedPreferenceApp,
                  baseCubit: baseCubit,
                ),
              ),
              BlocProvider<PeopleCubit>(
                create: (BuildContext context) => PeopleCubit(
                  repository: repository,
                  sharedPreference: sharedPreferenceApp,
                  baseCubit: baseCubit,
                ),
              ),
            ],
            child: const FavouriteShows(),
          ),
        );
      case scrPeopleScreen:
        return SlideRightRoute(
          page: MultiBlocProvider(
            providers: [
              BlocProvider<BaseCubit>(
                lazy: false,
                create: (BuildContext context) => BaseCubit(
                    repository: repository,
                    sharedPreference: sharedPreferenceApp),
              ),
              BlocProvider<PeopleCubit>(
                create: (BuildContext context) => PeopleCubit(
                  repository: repository,
                  sharedPreference: sharedPreferenceApp,
                  baseCubit: baseCubit,
                ),
              ),
            ],
            child: const PeopleScreen(),
          ),
        );
      case scrShowDetails:
        var d = settings.arguments;
        return SlideRightRoute(
          page: MultiBlocProvider(
            providers: [
              BlocProvider<BaseCubit>(
                lazy: false,
                create: (BuildContext context) => BaseCubit(
                    repository: repository,
                    sharedPreference: sharedPreferenceApp),
              ),
              BlocProvider<GetseriesCubit>(
                create: (BuildContext context) => GetseriesCubit(
                  repository: repository,
                  sharedPreference: sharedPreferenceApp,
                  baseCubit: baseCubit,
                ),
              ),
            ],
            child: ShowDetails(
              showDetails: d as Data,
            ),
          ),
        );

      case scrPeopleDetails:
        var d = settings.arguments;
        return SlideRightRoute(
          page: MultiBlocProvider(
            providers: [
              BlocProvider<BaseCubit>(
                lazy: false,
                create: (BuildContext context) => BaseCubit(
                    repository: repository,
                    sharedPreference: sharedPreferenceApp),
              ),
              BlocProvider<GetseriesCubit>(
                create: (BuildContext context) => GetseriesCubit(
                  repository: repository,
                  sharedPreference: sharedPreferenceApp,
                  baseCubit: baseCubit,
                ),
              ),
            ],
            child: PeopleDetails(
              peopleDetails: d as People,
            ),
          ),
        );

      case scrEpisodeDetails:
        var d = settings.arguments;
        return SlideRightRoute(
          page: MultiBlocProvider(
            providers: [
              BlocProvider<BaseCubit>(
                lazy: false,
                create: (BuildContext context) => BaseCubit(
                    repository: repository,
                    sharedPreference: sharedPreferenceApp),
              ),
              BlocProvider<GetseriesCubit>(
                create: (BuildContext context) => GetseriesCubit(
                  repository: repository,
                  sharedPreference: sharedPreferenceApp,
                  baseCubit: baseCubit,
                ),
              ),
            ],
            child: EpisodeDetails(
              episodeDetails: d as Episodes,
            ),
          ),
        );
    }
  }
}
