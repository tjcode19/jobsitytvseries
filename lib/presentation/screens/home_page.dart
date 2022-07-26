import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsitytvseries/constants/colours.dart';
import 'package:jobsitytvseries/cubit/base_cubit.dart';
import 'package:jobsitytvseries/cubit/getseries_cubit.dart';
import 'package:jobsitytvseries/cubit/people_cubit.dart';
import 'package:jobsitytvseries/data/network_services.dart';
import 'package:jobsitytvseries/data/repository.dart';
import 'package:jobsitytvseries/data/shared_preference.dart';
import 'package:jobsitytvseries/presentation/screens/favourite_shows.dart';
import 'package:jobsitytvseries/presentation/screens/main_page.dart';
import 'package:jobsitytvseries/presentation/screens/people_screen.dart';

import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  BaseCubit? stActive;

  void onTabTapped(int index) {
    if (index == 1) {
      // MyTransactions.globalKey.currentState!.listItems();
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        body: BlocProvider(
            create: (_) => BaseCubit(),
            child: Builder(
              builder: (context) {
                return IndexedStack(
                  index: _currentIndex,
                  children: [
                    // BlocProvider(
                    //   create: (context) => DashHomeCubit(),
                    //   child: DashboardHome(),
                    // ),
                    MultiBlocProvider(providers: [
                      BlocProvider<BaseCubit>(
                        lazy: false,
                        create: (BuildContext context) => BaseCubit(
                            repository:
                                Repository(networkService: NetworkService()),
                            sharedPreference: SharedPreferenceApp()),
                      ),
                      BlocProvider<GetseriesCubit>(
                        create: (BuildContext context) => GetseriesCubit(
                            repository:
                                Repository(networkService: NetworkService()),
                            baseCubit: BlocProvider.of<BaseCubit>(context),
                            sharedPreference: SharedPreferenceApp()),
                      ),
                      BlocProvider<PeopleCubit>(
                        create: (BuildContext context) => PeopleCubit(
                            repository:
                                Repository(networkService: NetworkService()),
                            baseCubit: BlocProvider.of<BaseCubit>(context),
                            sharedPreference: SharedPreferenceApp()),
                      ),
                    ], child: const MainPage()),
                    MultiBlocProvider(providers: [
                      BlocProvider<BaseCubit>(
                        lazy: false,
                        create: (BuildContext context) => BaseCubit(
                            repository:
                                Repository(networkService: NetworkService()),
                            sharedPreference: SharedPreferenceApp()),
                      ),
                      BlocProvider<PeopleCubit>(
                        create: (BuildContext context) => PeopleCubit(
                            repository:
                                Repository(networkService: NetworkService()),
                            baseCubit: BlocProvider.of<BaseCubit>(context),
                            sharedPreference: SharedPreferenceApp()),
                      ),
                    ], child: const PeopleScreen()),
                    MultiBlocProvider(
                      providers: [
                        BlocProvider<BaseCubit>(
                          lazy: false,
                          create: (BuildContext context) => BaseCubit(
                              repository:
                                  Repository(networkService: NetworkService()),
                              sharedPreference: SharedPreferenceApp()),
                        ),
                      ],
                      // create: (context) => SubjectBloc(),
                      child: const Settings(),
                    )
                  ],
                );
              },
            )),
        bottomNavigationBar: _bottom(),
        backgroundColor: whiteColour,
      ),
    );
  }

  Widget _bottom() {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      // this will be set when a new tab is tapped
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: const Icon(
            Icons.home,
            color: appSecondaryColor,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined),
          activeIcon: Icon(Icons.people),
          label: 'People',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: const Icon(Icons.settings),
          label: 'Settings',
        )
      ],
      selectedItemColor: appSecondaryColor,
      unselectedItemColor: appPrimaryColorLight,
    );
  }
}
