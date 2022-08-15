import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/home_lay.dart';
import 'package:newsapp/shared/Network/dio_helper.dart';

import 'blocobserver.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () {
      runApp( MyApp());
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark
          ),
          backgroundColor:Colors.white,
          elevation: 0,

        ),
      ),
      home: Home_layout(),
    );
  }

}