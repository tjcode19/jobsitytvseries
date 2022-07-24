import 'package:flutter/material.dart';
import 'package:jobsitytvseries/constants/colours.dart';
import 'package:jobsitytvseries/constants/enums.dart';
import 'package:jobsitytvseries/presentation/shared_widgets/main_page_container.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MainContainer(
      backAction: () {},
      child: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(''),
            ListView.separated(
                // key: _listKey,
                itemCount: 6,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                separatorBuilder: (BuildContext context, int index) {
                  return CustomLayout.msPad.sizedBoxH;
                },
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      height: 200,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Image.network(
                              "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
                            ),
                          ),
                          Column(
                            children: [Text('Title'), Text('Sub title')],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget itemList() {
    return ListTile(
      dense: true,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      horizontalTitleGap: 10,
      minLeadingWidth: 10,
      leading: Image.network(
        'https://static.tvmaze.co…m_portrait/81/202627.jpg',
        width: 24.0,
        height: 24.0,
      ),
      title: Text('e.accountName!',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
      subtitle: Text(''),
      trailing: RichText(
        text: TextSpan(
          text: 'GBP ',
          children: [
            TextSpan(
              text: '',
              style: const TextStyle(
                color: appPrimaryColor,
                fontSize: 15,
              ),
            ),
            TextSpan(
              text: '',
            )
          ],
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: appPrimaryColor.withOpacity(0.5),
            fontSize: 11,
          ),
        ),
      ),
      tileColor: appPrimaryColor,
      focusColor: appSecondaryColor,
      onTap: () {
        // transactionDetailsBottomSheet(context, data: e);
      },
    );
  }
}
