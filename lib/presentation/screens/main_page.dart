import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants/colours.dart';
import '/constants/enums.dart';
import '/constants/strings.dart';
import '/cubit/getseries_cubit.dart';
import '/cubit/people_cubit.dart';
import '/data/models/get_people.dart' as pop;
import '/data/models/get_shows.dart' as mod;
import '/presentation/shared_widgets/screen_title.dart';
import '/presentation/shared_widgets/secured_main_container.dart';
import '/presentation/shared_widgets/shimmer_widget.dart';
import '/presentation/shared_widgets/textinputs_widgets.dart';
import '/utils/device_utils.dart';
import 'package:shimmer/shimmer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<mod.Data> showList = [];
  List<mod.Data> mainShowList = [];
  List<mod.Data> searchedShowList = [];

  List<pop.People> peopleList = [];
  var favShow = <int?>{};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetseriesCubit>(context).getShows();
    BlocProvider.of<PeopleCubit>(context).getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return SecuredMainContainer(
      pageLabel: const ScreenTitle(
        title: 'TV Series',
        subTitle: 'Welcome here',
      ),
      pageLabelIcon: Container(),
      child: Column(
        children: [
          textInputField(
            context,
            hintTex: 'Enter Series Name',
            preIcon: const Icon(Icons.search_outlined),
            onChange: (val) {
              onSearchTextChanged(val.toLowerCase());
            },
          ),
          CustomLayout.mPad.sizedBoxH,
          BlocListener<GetseriesCubit, GetseriesState>(
            listenWhen: (prevState, state) {
              var oldData;
              var newData;

              if (state is GetShowSuccess) {
                prevState is GetShowSuccess;
                oldData = prevState;
                newData = state.getShows;
              }
              return oldData != newData;
            },
            listener: (context, state) {
              if (state is GetShowSuccess) {
                showList = state.getShows!;
                mainShowList = showList;

                setState(() {
                  showList = state.getShows!;
                  mainShowList = showList;
                  favShow = state.favs!;
                });
              }
            },
            child: showList.isNotEmpty
                ? SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 1.0) * 0.6,
                    child: GridView.builder(
                        // key: _listKey,
                        itemCount: showList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1.0,
                                childAspectRatio: 0.7,
                                mainAxisSpacing: 1.0),
                        itemBuilder: (BuildContext context, int index) {
                          return BlocBuilder<GetseriesCubit, GetseriesState>(
                            buildWhen: (prevState, state) {
                              return prevState != state;
                            },
                            builder: (context, state) {
                              if (state is UpdateFav) {
                                favShow = state.favs!;
                              }
                              return items(index);
                            },
                          );
                        }),
                  )
                : shimmerWidget(
                    row: 7,
                    height: (DeviceUtils.getScaledHeight(context, 1.0) * 0.6)
                        .toDouble()),
          ),
          CustomLayout.mPad.sizedBoxH,
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, scrPeopleScreen),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.find_in_page_outlined, color: appSecondaryColor),
                Text(
                  'Search more people',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      // color: whiteColour,
                      ),
                ),
              ],
            ),
          ),
          // CustomLayout.sPad.sizedBoxH,
          BlocListener<PeopleCubit, PeopleState>(
            listenWhen: (prevState, state) {
              var oldData;
              var newData;

              if (state is GetPeopleSuccess) {
                prevState is GetPeopleSuccess;
                oldData = prevState;
                newData = state.getPeople;
              }
              return oldData != newData;
            },
            listener: (context, state) {
              if (state is GetPeopleSuccess) {
                peopleList = state.getPeople!;

                setState(() {
                  peopleList = state.getPeople!;
                });
              }
            },
            child: peopleList.isNotEmpty
                ? SizedBox(
                    height: 120,
                    child: GridView.builder(
                        // key: _listKey,
                        scrollDirection: Axis.vertical,
                        itemCount: peopleList.isEmpty ? 0 : 4,
                        // shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 2.0,
                                childAspectRatio: 0.7,
                                mainAxisSpacing: 2.0),
                        itemBuilder: (BuildContext context, int index) {
                          return peopleItem(index);
                        }),
                  )
                : shimmerWidget(height: 120.0),
          )
        ],
      ),
      floatAction: GestureDetector(
        onTap: () => Navigator.pushNamed(context, scrFavouriteShow),
        child: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: appSecondaryColor),
          child: const Padding(
            padding: EdgeInsets.all(18.0),
            child: Icon(
              Icons.favorite,
              color: whiteColour,
            ),
          ),
        ),
      ),
    );
  }

  Widget peopleItem(int index) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, scrPeopleDetails,
          arguments: peopleList[index]),
      child: Card(
        child: Stack(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: true,
              child: Container(
                width: double.infinity,
                color: Colors.white,
              ),
            ),
            Image.network(
              peopleList[index].image!.medium!,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: blackColor.withOpacity(0.7),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  peopleList[index].name!,
                  style: const TextStyle(
                    color: whiteColour,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget items(int index) {
    if (favShow.contains(showList[index].id)) {
      showList[index].isfav = true;
    } else {
      showList[index].isfav = false;
    }
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, scrShowDetails,
          arguments: showList[index]),
      child: Card(
        child: Stack(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: true,
              child: Container(
                width: double.infinity,
                color: Colors.white,
              ),
            ),
            Image.network(
              showList[index].image!.medium!,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: blackColor.withOpacity(0.7),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  showList[index].name!,
                  style: const TextStyle(
                    color: whiteColour,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () {
                  if (showList[index].isfav!) {
                    BlocProvider.of<GetseriesCubit>(context)
                        .deletefav(data: showList[index]);
                  } else {
                    BlocProvider.of<GetseriesCubit>(context)
                        .savefav(data: showList[index]);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (showList[index].isfav!)
                      ? const Icon(
                          Icons.favorite,
                          color: whiteColour,
                        )
                      : const Icon(
                          Icons.favorite_border_outlined,
                          color: whiteColour,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    searchedShowList.clear();

    if (text.isEmpty) {
      setState(() {
        showList = mainShowList;
      });
      // _clearAllItems();
      return;
    }

    for (var showDetails in mainShowList) {
      if (showDetails.name!.toLowerCase().contains(text) ||
          showDetails.name!.contains(text)) {
        searchedShowList.add(showDetails);
      }
    }

    setState(() {
      showList = searchedShowList;
    });
    // _clearAllItems();
  }
}
