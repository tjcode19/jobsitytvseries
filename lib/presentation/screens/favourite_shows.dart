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
import 'package:jobsitytvseries/presentation/shared_widgets/screen_title.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/secured_main_container.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/textinputs_widgets.dart';
import 'package:jobsitytvseries/utils/device_utils.dart';

class FavouriteShows extends StatefulWidget {
  const FavouriteShows({Key? key}) : super(key: key);

  @override
  State<FavouriteShows> createState() => _FavouriteShowsState();
}

class _FavouriteShowsState extends State<FavouriteShows> {
  List<mod.Data> showList = [];
  List<mod.Data> mainShowList = [];
  List<mod.Data> searchedShowList = [];

  var favShow = <int?>{};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetseriesCubit>(context).favShows();
  }

  @override
  Widget build(BuildContext context) {
    return SecuredMainContainer(
      pageLabel: const ScreenTitle(
        title: 'Favourite Show',
        subTitle: 'These are your favourite shows',
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
            child: SizedBox(
              height: DeviceUtils.getScaledHeight(context, 1.0) * 0.8,
              child: showList.isNotEmpty
                  ? GridView.builder(
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
                      },
                    )
                  : const Center(
                      child: Text('You do not have any favourite show'),
                    ),
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
        ],
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
                  BlocProvider.of<GetseriesCubit>(context)
                      .deletefav(data: showList[index]);

                  setState(() {
                    showList
                        .removeWhere((item) => item.id == showList[index].id);
                  });
                },
                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite,
                      color: whiteColour,
                    )),
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
