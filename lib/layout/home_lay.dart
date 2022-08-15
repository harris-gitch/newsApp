import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/models/ItemBarModel.dart';
import 'package:newsapp/modules/business.dart';
import 'package:newsapp/modules/entertaiments.dart';
import 'package:newsapp/modules/science.dart';
import 'package:newsapp/modules/sports.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';

import '../shared/componants/componants.dart';

class Home_layout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext contxt)=> NewsCubit(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        builder: (context, state) {
          var cubit= NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
                elevation: 0,
                title: Text('Nwes App',style: TextStyle(fontSize: 24 ,fontWeight:FontWeight.bold,color: Colors.black ),),
                actions: [
                  IconButton(
                    onPressed: () {
                      // navigateTo(context, SearchScreen());
                    },
                    color: Colors.black,
                    icon: Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  IconButton(
                    onPressed: () {
                      // ModeCubit.get(context).changeAppMode();
                    },
                    color: Colors.black,
                    icon: Icon(
                      // Icons.brightness_4_outlined,
                      Icons.settings,
                      size: 30.0,
                    ),
                  ),]),
            body: SafeArea(
              child: Column(
                children: [

                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Container(
                            height: 100,
                            width: 410,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder:( context,int index)=> ItemBarBuild(cubit.list[index],index,context), separatorBuilder:( context,int index)=> SizedBox(width: 10,), itemCount:cubit.list.length)),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Container(
                          width: double.maxFinite,
                          child: cubit.screen[cubit.CurrentInd])),
                ],
              ),
            ),
          );
        },
        listener: ( context,state){},
      ),
    );
  }

}
