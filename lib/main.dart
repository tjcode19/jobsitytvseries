import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'constants/colours.dart';
import 'presentation/routes.dart';
import 'utils/custom_anim.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter? appRouter;

  const MyApp({Key? key, this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: appRouter?.generateRoute,
       builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.pouringHourGlass
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 35.0
    ..radius = 10.0
    ..progressColor = whiteColour
    ..backgroundColor = appPrimaryColor
    ..indicatorColor = whiteColour
    ..textColor = whiteColour
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true
    ..fontSize = 16.0
    ..errorWidget = Column(
      children: const [
        Icon(
          Icons.error_outline,
          color: whiteColour,
          size: 35.0,
        ),
        Text(
          'Error',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: whiteColour),
        )
      ],
    )
    ..customAnimation = CustomAnimation();
  // ..indicatorWidget = Text('Where ererer');
}
