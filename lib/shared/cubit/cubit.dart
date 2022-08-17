import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/general.dart';
import 'package:newsapp/shared/Network/dio_helper.dart';
import 'package:newsapp/shared/cubit/states.dart';

import '../../models/ItemBarModel.dart';
import '../../modules/business.dart';
import '../../modules/entertaiments.dart';
import '../../modules/science.dart';
import '../../modules/sports.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialsState());
 static NewsCubit get(context)=>BlocProvider.of(context);
 int CurrentInd=0;
  List screen=[
    General(),
    Sports(),
    Science(),
    Entertaimnets(),
    Business()
  ];

  List<itemBar> list=[
    itemBar(name: 'General', img: 'assets/general.png'),
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
  void getBusiness(){
    emit(NewsLoadingBusinessState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'us',
          'category':'business',
          'apiKey':'573c5df6ca3c4b309a1e88c66f0b4a81'
        }
    ).then((value)  {
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessState());
    }).catchError((e){
      print(e.toString());
      emit(NewsErrorBusinessState(e.toString()));
    });
  }
  List<dynamic> sports=[];
  void getSport(){
    emit(NewsLoadingSportsState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'us',
          'category':'sports',
          'apiKey':'573c5df6ca3c4b309a1e88c66f0b4a81'
        }
    ).then((value)  {
      sports=value.data['articles'];
      //print(business[0]['title']);
      emit(NewsGetSportsState());
    }).catchError((e){
      print(e.toString());
      emit(NewsErrorSportsState(e.toString()));
    });
  }
  List<dynamic> science=[];
  void getScience(){
    emit(NewsLoadingScienceState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'us',
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
  void getEntertainment(){
    emit(NewsLoadingEnterState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'us',
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
      print(general[0]['title']);
      emit(NewsGetGeneralState());
    }).catchError((e){
      print(e.toString());
      emit(NewsErrorGeneralState(e.toString()));
    });
  }
}
