import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jobsitytvseries/constants/colours.dart';
import 'package:jobsitytvseries/constants/enums.dart';
import 'package:jobsitytvseries/constants/strings.dart';
import 'package:jobsitytvseries/cubit/getseries_cubit.dart';
import 'package:jobsitytvseries/data/models/get_episodes.dart' as epi;
import 'package:jobsitytvseries/data/models/get_people.dart' as pop;
import 'package:jobsitytvseries/data/models/get_shows.dart' as mod;
import 'package:jobsitytvseries/presentation/shared_widgets/custom_cont.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/main_page_container.dart';

class PeopleDetails extends StatefulWidget {
  final pop.People? peopleDetails;
  const PeopleDetails({Key? key, this.peopleDetails}) : super(key: key);

  @override
  State<PeopleDetails> createState() => _PeopleDetailsState();
}

class _PeopleDetailsState extends State<PeopleDetails> {
  pop.People? peopleDetails;

  List<Season>? seasons = [];
  var season = <int?>{};

  @override
  void initState() {
    super.initState();

    peopleDetails = widget.peopleDetails;
    BlocProvider.of<GetseriesCubit>(context).getEpisodes(peopleDetails!.id);
  }

  @override
  Widget build(BuildContext context) {
    String days = '';
    String genre = '';
    // for (var element in peopleDetails!.schedule!.days!) {
    //   days += element + ",";
    // }

    // for (var element in showDetails!.genres!) {
    //   genre += element + ",";
    // }

    return MainContainer(
      backAction: () {},
      child: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.network(
                          peopleDetails!.image != null
                              ? peopleDetails!.image!.medium!
                              : 'https://www.si.edu/sites/default/files/newsdesk/fact_sheets/anonymous_silhouette_0.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      CustomLayout.lPad.sizedBoxW,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              peopleDetails!.name!,
                              style: const TextStyle(fontSize: 24),
                            ),
                            CustomLayout.lPad.sizedBoxH,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Day & Time'),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.red,
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(peopleDetails!.gender!),
                                    ),
                                    Text('$days '),
                                  ],
                                ),
                              ],
                            ),
                            CustomLayout.lPad.sizedBoxH,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Genre'),
                                Text('$genre '),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  CustomLayout.lPad.sizedBoxH,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${peopleDetails!.birthday}',
                    ),
                    // Text(
                    //   showDetails!.summary!,
                    //   textAlign: TextAlign.justify,
                    // ),
                  ),
                ],
              ),
            ),
            CustomLayout.lPad.sizedBoxH,
            BlocBuilder<GetseriesCubit, GetseriesState>(
              buildWhen: (old, newState) {
                return old != newState;
              },
              builder: (buildContext, state) {
                if (state is GetEpisodesSuccess) {
                  var episodes = state.getEpisodes;
                  season.clear();
                  seasons!.clear();

                  for (int a = 0; a < episodes!.length; a++) {
                    season.add(episodes[a].season);
                  }

                  for (var element in season) {
                    List<epi.Episodes> result =
                        episodes.where((o) => o.season == element).toList();

                    seasons!.add(Season(id: element, epis: result));
                  }
                }
                return Column(
                  children: seasons!.map((s) {
                    return Container(
                      child: Card(
                        child: ListTile(
                          title: Text('Season ${s.id.toString()}'),
                          subtitle: Wrap(
                            children: [
                              ...s.epis!.map(
                                (val) => CustomCont(
                                  action: () {
                                    Navigator.pushNamed(
                                        context, scrEpisodeDetails,
                                        arguments: val);
                                  },
                                  hMargin: 5.0,
                                  vMargin: 6.0,
                                  bgColor: appSecondaryColor,
                                  shadow: false,
                                  child: Text(
                                    val.number.toString(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsItem({field, val}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field),
        Text(val),
      ],
    );
  }
}

class Season {
  int? id;
  List<epi.Episodes>? epis;

  Season({this.id, this.epis});
}
