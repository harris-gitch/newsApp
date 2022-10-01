
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/models/headlines_model.dart';
import 'package:newsapp/modules/general.dart';
import 'package:newsapp/shared/Network/remote/dio_helper.dart';
import 'package:newsapp/shared/componants/constants.dart';
import 'package:newsapp/shared/cubit/states.dart';

import '../../models/ItemBarModel.dart';
import '../../modules/business.dart';
import '../../modules/entertaiments.dart';
import '../../modules/science.dart';
import '../../modules/sports.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialsState());
 static NewsCubit get(context)=>BlocProvider.of(context);
 final countryPicker=const FlCountryCodePicker();
 CountryCode? countryCode;
 HeadlinesModel? headlinesModel;
 int CurrentInd=0;
  List screen=[
   // General(),
    Sports(),
    Science(),
    Entertaimnets(),
    Business()
  ];

  void changeflag(CountryCode flag){
   print(flag);
    countryCode=flag;
    emit(GetFlagState());
  }

  List<itemBar> list=[
   // itemBar(name: 'General', img: 'assets/general.png'),
    itemBar(name: 'sports', img: 'assets/sports.png'),
    itemBar(name: 'science', img: 'assets/science.png'),
    itemBar(name: 'entertaiments', img: 'assets/netflix.png'),
    itemBar(name: 'buisness', img: 'assets/business.png')
  ];
  void ChangeIndex(int index) {
    CurrentInd = index;
    emit(NewsTolBarSate());
  }
  List<dynamic> business=[];
  void getBusiness(String code){
    emit(NewsLoadingBusinessState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':code,
          'category':'business',
          'apiKey':'573c5df6ca3c4b309a1e88c66f0b4a81'
        }
    ).then((value)  {
      business=value.data['articles'];
    //  print(business[0]['title']);
      emit(NewsGetBusinessState());
    }).catchError((e){
      print(e.toString());
      emit(NewsErrorBusinessState(e.toString()));
    });
  }

//this method to get list of articles and display to topHeadLines list
  List<dynamic> topHeadLines=[];
  void getTopHeadLines(String code){
    emit(NewsLoadingHeadlinesState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':code,
          'apiKey':'573c5df6ca3c4b309a1e88c66f0b4a81'
        }
    ).then((value)  {
      topHeadLines=value.data['articles'];
      emit(NewsGetHeadlinesState());
    }).catchError((e){
      print(e.toString());
      emit(NewsErrorHeadlinesState(e.toString()));
    });
  }

  List<dynamic> sports=[];
  void getSport(String code){
    emit(NewsLoadingSportsState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':code,
          'category':'sports',
          'apiKey':'573c5df6ca3c4b309a1e88c66f0b4a81'
        }
    ).then((value)  {
      sports=value.data['articles'];
      //print(business[0]['title']);
      emit(NewsGetSportsState(sports));
    }).catchError((e){
      print(e.toString());
      emit(NewsErrorSportsState(e.toString()));
    });
  }

  List<dynamic> science=[];
  void getScience(String code){
    emit(NewsLoadingScienceState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':code,
          'category':'science',
          'apiKey':'573c5df6ca3c4b309a1e88c66f0b4a81'
        }
    ).then((value)  {
      science=value.data['articles'];
      //print(business[0]['title']);
      emit(NewsGetScienceState());
    }).catchError((e){
      print(e.toString());
      emit(NewsErrorScienceState(e.toString()));
    });
  }

  List<dynamic> entertainment=[];
  void getEntertainment(String code){
    emit(NewsLoadingEnterState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':code,
          'category':'Entertainment',
          'apiKey':'573c5df6ca3c4b309a1e88c66f0b4a81'
        }
    ).then((value)  {
      entertainment=value.data['articles'];
      //print(business[0]['title']);
      emit(NewsGetEnterState());
    }).catchError((e){
      print(e.toString());
      emit(NewsErrorEnterState(e.toString()));
    });
  }
  List<dynamic> general=[];
  void getGeneral(){
    emit(NewsLoadingGeneralState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'us',
          'category':'general',
          'apiKey':'573c5df6ca3c4b309a1e88c66f0b4a81'
        }
    ).then((value)  {
      general=value.data['articles'];
   //   print(general[0]['title']);
      emit(NewsGetGeneralState());
    }).catchError((e){
      print(e.toString());
      emit(NewsErrorGeneralState(e.toString()));
    });
  }


  List<dynamic> search = [];

  void getSearch(String value,String code) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '0803a9972d064bd8b3b7379123ea164c',
      },
    ).then((value) {
      //debugPrint(value.data['articles'][0]['title']);
      search = value.data['articles'];
     // debugPrint(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
     // debugPrint(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
