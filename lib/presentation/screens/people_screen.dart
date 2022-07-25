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

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  List<pop.People> peopleList = [];
  List<pop.People> mainList = [];
  List<pop.People> searchedList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PeopleCubit>(context).getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      backAction: () {},
      child: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            textInputField(
              context,
              hintTex: 'Search People by Name',
              preIcon: const Icon(Icons.search_outlined),
              onChange: (val) {
                onSearchTextChanged(val.toLowerCase());
              },
            ),
            CustomLayout.mPad.sizedBoxH,
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
                  mainList = state.getPeople!;

                  setState(() {
                    peopleList = state.getPeople!;
                  });
                }
              },
              child: SizedBox(
                height: DeviceUtils.getScaledHeight(context, 1.0) * 0.85,
                child: GridView.builder(
                    // key: _listKey,
                    itemCount: peopleList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1.0,
                            childAspectRatio: 0.7,
                            mainAxisSpacing: 1.0),
                    itemBuilder: (BuildContext context, int index) {
                      return peopleItem(index);
                    }),
              ),
            ),
            // CustomLayout.sPad.sizedBoxH,
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
              peopleList[index].image != null
                  ? peopleList[index].image!.medium!
                  : 'https://www.si.edu/sites/default/files/newsdesk/fact_sheets/anonymous_silhouette_0.jpg',
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

  onSearchTextChanged(String text) async {
    searchedList.clear();

    if (text.isEmpty) {
      setState(() {
        peopleList = mainList;
      });
      // _clearAllItems();
      return;
    }

    for (var showDetails in mainList) {
      if (showDetails.name!.toLowerCase().contains(text) ||
          showDetails.name!.contains(text)) {
        searchedList.add(showDetails);
      }
    }

    setState(() {
      peopleList = searchedList;
    });
    // _clearAllItems();
  }
}
