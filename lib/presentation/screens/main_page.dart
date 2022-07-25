import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsitytvseries/constants/colours.dart';
import 'package:jobsitytvseries/constants/enums.dart';
import 'package:jobsitytvseries/constants/strings.dart';
import 'package:jobsitytvseries/cubit/getseries_cubit.dart';
import 'package:jobsitytvseries/cubit/people_cubit.dart';
import 'package:jobsitytvseries/data/models/get_people.dart' as pop;
import 'package:jobsitytvseries/data/models/get_shows.dart' as mod;
import 'package:jobsitytvseries/presentation/shared_widgets/main_page_container.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/textinputs_widgets.dart';
import 'package:jobsitytvseries/utils/device_utils.dart';

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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetseriesCubit>(context).getShows();
    BlocProvider.of<PeopleCubit>(context).getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      backAction: () {},
      child: Container(
        padding: EdgeInsets.all(25.0),
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
                  });
                }
              },
              child: SizedBox(
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
                      return items(index);
                    }),
              ),
            ),
            CustomLayout.mPad.sizedBoxH,
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, scrPeopleScreen),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.find_in_page_outlined),
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
              child: SizedBox(
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
              ),
            )
          ],
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
                padding: EdgeInsets.all(8.0),
                child: Text(
                  peopleList[index].name!,
                  style: TextStyle(
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
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, scrShowDetails,
          arguments: showList[index]),
      child: Card(
        child: Stack(
          children: [
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
                padding: EdgeInsets.all(8.0),
                child: Text(
                  showList[index].name!,
                  style: TextStyle(
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
