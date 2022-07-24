import 'package:flutter/material.dart';
import 'package:jobsitytvseries/constants/colours.dart';
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

   @override
  void initState() {
    super.initState();

    showDetails = widget.showDetails;
  }
  @override
  Widget build(BuildContext context) {
    return MainContainer(
       backAction: () {},
      child:
          Container(padding: EdgeInsets.all(25.0), child: Column(children: [
            Card(
      child: Stack(
        children: [
          Image.network(
             showDetails!.image!.medium!,
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
                 showDetails!.name!,
                style: TextStyle(color: whiteColour,),
              ),
            ),
          ),
        ],
      ),
    )
          ])),
    );
  }
}
