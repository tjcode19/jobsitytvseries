import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '/constants/colours.dart';
import '/constants/enums.dart';
import '/constants/strings.dart';
import '/cubit/getseries_cubit.dart';
import '/data/models/get_episodes.dart' as epi;
import '/data/models/get_shows.dart' as mod;
import '/data/models/season_model.dart';
import '/presentation/shared_widgets/custom_cont.dart';
import '/presentation/shared_widgets/screen_title.dart';
import '/presentation/shared_widgets/secured_main_container.dart';
import '/presentation/shared_widgets/shimmer_widget.dart';
import '/utils/device_utils.dart';

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
      days += element + ", ";
    }

    for (var element in showDetails!.genres!) {
      genre += element + ", ";
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
                      height: 180,
                      child: Stack(
                        children: [
                          shimmerImage(
                            width:
                                DeviceUtils.getScaledWidth(context, 1.0) * 0.35,
                          ),
                          Image.network(
                            showDetails!.image!.original!,
                            fit: BoxFit.fill,
                            width:
                                DeviceUtils.getScaledWidth(context, 1.0) * 0.35,
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
                              const Text('Time'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomCont(
                                    bgColor: Colors.red,
                                    vPadding: 8.0,
                                    child: Text(
                                      showDetails!.schedule!.time!,
                                      style:
                                          const TextStyle(color: whiteColour),
                                    ),
                                  ),
                                  CustomLayout.lPad.sizedBoxH,
                                  const Text('Day(s)'),
                                  Text(
                                    '$days ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CustomLayout.lPad.sizedBoxH,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Genre'),
                              Text(
                                '$genre ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(
                    data: showDetails!.summary!,
                    style: {
                      "p": Style(
                          color: appPrimaryColor, textAlign: TextAlign.justify),
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
          CustomLayout.mPad.sizedBoxH,
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
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...seasons!.map((s) {
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
                                        style:
                                            const TextStyle(color: whiteColour),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      CustomLayout.lPad.sizedBoxH,
                    ],
                  ),
                ),
              );
            },
          ),
          CustomLayout.lPad.sizedBoxH,
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


