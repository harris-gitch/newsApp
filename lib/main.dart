import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/layout/cubit/cubit.dart';
import 'package:newsapp/layout/cubit/state.dart';
import 'package:newsapp/layout/home_lay.dart';
import 'package:newsapp/shared/Network/local/cache_helper.dart';

import 'package:newsapp/shared/Network/remote/dio_helper.dart';
import 'package:newsapp/shared/componants/constants.dart';
import 'package:newsapp/shared/cubit/cubit.dart';

import 'blocobserver.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  codeFl= CacheHelper.getData(key: 'codeFl');
  print(codeFl);
  runApp(MyApp(isDark: isDark,codeFl: codeFl,));
  Bloc.observer= MyBlocObserver();

}

class MyApp extends StatelessWidget {

  final bool? isDark;
  final String? codeFl;

  MyApp({
    this.isDark,
    this.codeFl
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider( create: (BuildContext contxt)=> NewsCubit()..getGeneral..getSport(codeFl!)..getScience(codeFl!)..getEntertainment(codeFl!)..getBusiness(codeFl!)..getTopHeadLines(codeFl!), ),
        BlocProvider(create: (BuildContext context)=>ModeCubit()..changeAppMode( fromShared: isDark,),)
      ],
      child: BlocConsumer<ModeCubit,ModeStates>(
          builder: (context,state){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch:Colors.green,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              titleSpacing: 20.0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.green,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: HexColor('#262626'),
            appBarTheme: AppBarTheme(
              titleSpacing: 20.0,

              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('#262626'),
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: HexColor('#262626'),
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.green,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          themeMode:ModeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: Home_layout(),
        );
      }, listener: (context,state){}),
    );
  }

}