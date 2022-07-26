import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/constants/colours.dart';
import '/constants/enums.dart';
import '/cubit/base_cubit.dart';
import '/cubit/getseries_cubit.dart';
import '/cubit/people_cubit.dart';
import '/data/network_services.dart';
import '/data/repository.dart';
import '/data/shared_preference.dart';
import '/presentation/screens/main_page.dart';
import '/presentation/screens/people_screen.dart';

import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  BaseCubit? stActive;
  int count = 0;

  closeApp() {
    if (_currentIndex == 0 && count == 0) {
      BlocProvider.of<BaseCubit>(context).showError(
          errorMsg: 'Tap back one more time to close app',
          type: ErrorMsgType.toast,
          toastPosition: EasyLoadingToastPosition.bottom);

      setState(() {
        count++;
      });

      Timer(const Duration(seconds: 5), () {
        setState(() {
          count = 0;
        });
      });
    } else if (_currentIndex == 0 && count > 0) {
      exit(0);
    } else {
      onTabTapped(0);
    }
  }

  void onTabTapped(int index) {
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
      onWillPop: () => closeApp(),
      child: Scaffold(
        body: BlocProvider(
            create: (_) => BaseCubit(),
            child: Builder(
              builder: (context) {
                return IndexedStack(
                  index: _currentIndex,
                  children: [
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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon:  Icon(
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
          activeIcon: Icon(Icons.settings),
          label: 'Settings',
        )
      ],
      selectedItemColor: appSecondaryColor,
      unselectedItemColor: appPrimaryColorLight,
    );
  }
}
