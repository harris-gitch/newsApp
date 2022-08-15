import 'package:flutter_bloc/flutter_bloc.dart';
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
    Sports(),
    Science(),
    Entertaimnets(),
    Business()
  ];

  List<itemBar> list=[
    itemBar(name: 'sports', img: 'assets/sports.png'),
    itemBar(name: 'science', img: 'assets/science.png'),
    itemBar(name: 'entertaiments', img: 'assets/netflix.png'),
    itemBar(name: 'buisness', img: 'assets/business.png')
  ];
  void ChangeIndex(int index) {
    CurrentInd = index;
    emit(NewsTolBarSate());
  }
}
