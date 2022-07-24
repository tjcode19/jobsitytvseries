import 'package:flutter/material.dart';
import 'package:jobsitytvseries/constants/enums.dart';
import 'package:jobsitytvseries/data/models/get_episodes.dart' as Ep;
import 'package:jobsitytvseries/presentation/shared_widgets/main_page_container.dart';

class EpisodeDetails extends StatefulWidget {
  final Ep.Episodes? episodeDetails;
  const EpisodeDetails({Key? key, this.episodeDetails}) : super(key: key);

  @override
  State<EpisodeDetails> createState() => _EpisodeDetailsState();
}

class _EpisodeDetailsState extends State<EpisodeDetails> {

Ep.Episodes? episodesDetails;

@override
  void initState() {
    super.initState();

    episodesDetails = widget.episodeDetails;
  }
  @override
  Widget build(BuildContext context) {
    return MainContainer(
        backAction: () {},
        child: Container(
            padding: const EdgeInsets.all(25.0), child: Column(children: [
              Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.network(
                          episodesDetails!.image!.medium!,
                          fit: BoxFit.fill,
                        ),
                      ),
                      CustomLayout.lPad.sizedBoxW,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              episodesDetails!.name!,
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
                                      child: Text(episodesDetails!.number.toString()),
                                    ),
                                    // Text('$days '),
                                  ],
                                ),
                              ],
                            ),
                            CustomLayout.lPad.sizedBoxH,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Genre'),
                                // Text('$genre '),
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
                      episodesDetails!.summary!,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            ])));
  }
}
