import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/cubit/cubit.dart';

import '../../models/ItemBarModel.dart';
import '../../layout/home_lay.dart';
Widget ItemBarBuild(itemBar list,index,context)=>  GestureDetector(
  onTap: (){
    NewsCubit.get(context).ChangeIndex(index);
  },
  child:
  Container(
    height: 100,
    //width: 190,
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(list.img),
        Text(list.name,style: TextStyle(fontSize: 20 , color: Colors.white),),
      ],

    ),
  ),
);