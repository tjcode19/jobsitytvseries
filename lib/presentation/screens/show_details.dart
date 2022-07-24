import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsitytvseries/constants/colours.dart';
import 'package:jobsitytvseries/constants/enums.dart';
import 'package:jobsitytvseries/cubit/getseries_cubit.dart';
import 'package:jobsitytvseries/data/models/get_shows.dart' as mod;
import 'package:jobsitytvseries/presentation/shared_widgets/main_page_container.dart';

class ShowDetails extends StatefulWidget {
  final mod.Data? showDetails;
  const ShowDetails({Key? key, this.showDetails}) : super(key: key);

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  mod.Data? showDetails;

  List<String>? seasons = [];

  @override
  void initState() {
    super.initState();

    showDetails = widget.showDetails;
     BlocProvider.of<GetseriesCubit>(context).getEpisodes(250);
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

    return MainContainer(
      backAction: () {},
      child: Container(
        padding: const EdgeInsets.all(25.0),
        child: Card(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.network(
                      showDetails!.image!.original!,
                      fit: BoxFit.fill,
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
                            Text('Day & Time'),
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
              CustomLayout.lPad.sizedBoxH,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(showDetails!.summary!, textAlign: TextAlign.justify,),
              ),
            ],
          ),
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
