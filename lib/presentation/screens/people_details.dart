import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants/colours.dart';
import '/constants/enums.dart';
import '/cubit/people_cubit.dart';
import '/data/models/get_episodes.dart' as epi;
import '/data/models/get_featured_series.dart' as fe;
import '/data/models/get_people.dart' as pop;
import '/presentation/shared_widgets/custom_cont.dart';
import '/presentation/shared_widgets/screen_title.dart';
import '/presentation/shared_widgets/secured_main_container.dart';
import '/presentation/shared_widgets/shimmer_widget.dart';
import '/utils/device_utils.dart';

class PeopleDetails extends StatefulWidget {
  final pop.People? peopleDetails;
  const PeopleDetails({Key? key, this.peopleDetails}) : super(key: key);

  @override
  State<PeopleDetails> createState() => _PeopleDetailsState();
}

class _PeopleDetailsState extends State<PeopleDetails> {
  pop.People? peopleDetails;

  List<fe.ShowsDetails>? shows = [];

  @override
  void initState() {
    super.initState();

    peopleDetails = widget.peopleDetails;
    BlocProvider.of<PeopleCubit>(context)
        .getFeaturesSeries(personId: peopleDetails!.id);
  }

  @override
  Widget build(BuildContext context) {
    return SecuredMainContainer(
      pageLabel: ScreenTitle(
        title: peopleDetails!.name!,
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
                              const Text('Gender'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomCont(
                                    bgColor: peopleDetails!.gender! == 'Male'
                                        ? appSecondaryColor
                                        : Colors.pink,
                                    vPadding: 8.0,
                                    child: Text(
                                      peopleDetails!.gender!,
                                      style:
                                          const TextStyle(color: whiteColour),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CustomLayout.lPad.sizedBoxH,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Date of Birth'),
                              Text(
                                '${peopleDetails!.birthday}',
                                style: const TextStyle(
                                    color: appPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          CustomLayout.lPad.sizedBoxH,
          const Text(
            'Featured Series',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          // CustomLayout.mPad.sizedBoxH,
          BlocBuilder<PeopleCubit, PeopleState>(
            buildWhen: (old, newState) {
              return old != newState;
            },
            builder: (buildContext, state) {
              if (state is GetFeaturedSuccess) {
                shows = state.featuredShows;
              }
              return shows!.isNotEmpty
                  ? SizedBox(
                      height: DeviceUtils.getScaledHeight(context, 0.5),
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: [
                            ...shows!.map(
                              (val) => Card(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 120,
                                          width: 80,
                                          child: Image.network(
                                            val.eEmbedded!.show!.image!.medium!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        CustomLayout.lPad.sizedBoxW,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                val.eEmbedded!.show!.name!,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              CustomLayout.mPad.sizedBoxH,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text('URL'),
                                                  Text(
                                                    '${val.eEmbedded!.show!.url}',
                                                    style: const TextStyle(
                                                        color: appPrimaryColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : shimmerWidget(
                      row: 7,
                      height: (DeviceUtils.getScaledHeight(context, 1.0) * 0.5)
                          .toDouble());
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
