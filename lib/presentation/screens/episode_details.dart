import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '/constants/colours.dart';
import '/constants/enums.dart';
import '/data/models/get_episodes.dart' as ep;
import '/presentation/shared_widgets/screen_title.dart';
import '/presentation/shared_widgets/secured_main_container.dart';

class EpisodeDetails extends StatefulWidget {
  final ep.Episodes? episodeDetails;
  const EpisodeDetails({Key? key, this.episodeDetails}) : super(key: key);

  @override
  State<EpisodeDetails> createState() => _EpisodeDetailsState();
}

class _EpisodeDetailsState extends State<EpisodeDetails> {
  ep.Episodes? episodesDetails;

  @override
  void initState() {
    super.initState();

    episodesDetails = widget.episodeDetails;
  }

  @override
  Widget build(BuildContext context) {
    return SecuredMainContainer(
      pageLabel: ScreenTitle(
        title: episodesDetails!.name!,
        isBackButton: true,
      ),
      pageLabelIcon: Container(),
      child: Column(
        children: [
          Card(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Image.network(
                    episodesDetails!.image!.medium!,
                    fit: BoxFit.fill,
                  ),
                ),
                CustomLayout.lPad.sizedBoxH,
                Row(
                  children: [
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
                              RichText(
                                text: TextSpan(
                                  text: 'Season ${episodesDetails!.season}',
                                  children: [
                                    TextSpan(
                                      text:
                                          ' Episode ${episodesDetails!.number}',
                                      style: const TextStyle(
                                          color: appPrimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: bodyTextColor,
                                  ),
                                ),
                              )
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
                    data: episodesDetails!.summary!,
                    style: {
                      "p": Style(
                          color: appPrimaryColor, textAlign: TextAlign.justify),
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
