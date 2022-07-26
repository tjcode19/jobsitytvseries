import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jobsitytvseries/constants/colours.dart';
import 'package:jobsitytvseries/constants/enums.dart';
import 'package:jobsitytvseries/constants/strings.dart';
import 'package:jobsitytvseries/cubit/getseries_cubit.dart';
import 'package:jobsitytvseries/data/models/get_episodes.dart' as epi;
import 'package:jobsitytvseries/data/models/get_shows.dart' as mod;
import 'package:jobsitytvseries/presentation/shared_widgets/custom_cont.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/main_page_container.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/screen_title.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/secured_main_container.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/shimmer_widget.dart';
import 'package:jobsitytvseries/utils/device_utils.dart';
import 'package:shimmer/shimmer.dart';

class ShowDetails extends StatefulWidget {
  final mod.Data? showDetails;
  const ShowDetails({Key? key, this.showDetails}) : super(key: key);

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  mod.Data? showDetails;

  List<Season>? seasons = [];
  var season = <int?>{};

  @override
  void initState() {
    super.initState();

    showDetails = widget.showDetails;
    BlocProvider.of<GetseriesCubit>(context).getEpisodes(showDetails!.id);
  }

  @override
  Widget build(BuildContext context) {
    String days = '';
    String genre = '';
    for (var element in showDetails!.schedule!.days!) {
      days += element + ",";
    }

    for (var element in showDetails!.genres!) {
      genre += element + ",";
    }

    return SecuredMainContainer(
      pageLabel: ScreenTitle(
        title: showDetails!.name!,
        isBackButton: true,
      ),
      pageLabelIcon: Container(),
      
      child: Column(
        children: [
          Card(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          shimmerImage(
                            width: DeviceUtils.getScaledWidth(context, 1.0) *
                                0.35,
                          ),
                          Image.network(
                            showDetails!.image!.original!,
                            fit: BoxFit.fill,
                            width: DeviceUtils.getScaledWidth(context, 1.0) *
                                0.35,
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Icon(
                              showDetails!.isfav! == true
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: whiteColour,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomLayout.lPad.sizedBoxW,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            showDetails!.name!,
                            style: const TextStyle(fontSize: 24),
                          ),
                          CustomLayout.lPad.sizedBoxH,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Day & Time'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.red,
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(showDetails!.schedule!.time!),
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
                CustomLayout.mPad.sizedBoxH,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(
                    data: showDetails!.summary!,
                    style: {
                      "p": Style(
                          color: appPrimaryColor,
                          textAlign: TextAlign.justify),
                    },
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
                                  style: const TextStyle(color: whiteColour),
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
