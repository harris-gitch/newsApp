import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/componants/constants.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';

import '../modules/search.dart';
import '../modules/webview_screen.dart';
import '../shared/Network/local/cache_helper.dart';
import '../shared/componants/componants.dart';
import 'cubit/cubit.dart';

class Home_layout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (context, state) {
        var list=NewsCubit.get(context).topHeadLines;
        var cubit= NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
              elevation: 0,
              title: Text('News App',style: TextStyle(fontSize: 24 ,fontWeight:FontWeight.bold, ),),
              actions: [
                IconButton(
                  onPressed: () {
                     ModeCubit.get(context).changeAppMode();
                  },

                  icon: Icon(
                    Icons.brightness_4_outlined,
                    size: 30.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: ()async{
                      final code= await NewsCubit.get(context).countryPicker.showPicker(context: context);
                      NewsCubit.get(context).changeflag(code!);
                     // print(code.code);
                      CacheHelper.saveData(key: 'codeFl', value: code.code).then((value) => print(value));
                    },
                    child: Container(
                      height: 30,
                      width: 50,
                      child: NewsCubit.get(context).countryCode != null
                          ? NewsCubit.get(context).countryCode!.flagImage
                          :  codeFl !=null ?CountryCodeFlag(flagUri: 'assets/flags/${codeFl?.toLowerCase()}.png') : Icon(Icons.flag_rounded),
                    ),
                  ),
                ),
              ]),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                  top: 5,
                  left: 15
                ),
                child: Text('Break News',style:Theme.of(context).textTheme.bodyText1,maxLines: 3,),
              ),
             SizedBox(height: 10,),
              ConditionalBuilder(
                  condition:list.length >0,
                  builder: (context)=>CarouselSlider(items: List.generate(5,(index) => InkWell(
                onTap:(){
                  navigateTo(context, WebViewScreen( url: list[index]['url'],));
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child:Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: NetworkImage(NewsCubit.get(context).topHeadLines[index]['urlToImage']!),
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        alignment: Alignment.bottomCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                            child: Container(
                              color: Colors.black.withOpacity(0.2),
                              child: Center(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(NewsCubit.get(context).topHeadLines[index]['title'],style: TextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              )),
                  options: CarouselOptions(
                      height: 200,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      viewportFraction: 0.9,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 4),
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayCurve: Curves.linear,
                      scrollDirection: Axis.horizontal
                  )),
                  fallback: (context)=>Center(child: CircularProgressIndicator())),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8,
                    top: 5,
                    left: 15
                ),
                child: Text('Categories',style:Theme.of(context).textTheme.bodyText1,maxLines: 3,),
              ),
              SizedBox(height: 10,),
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
              SizedBox(height: 5,),
              Expanded(
                  flex: 5,
                  child: Container(
                      width: double.maxFinite,
                      child: cubit.screen[cubit.CurrentInd])),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              NewsCubit.get(context).getGeneral();
              navigateTo(context, SearchScreen());
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.search),
          ),
        );
      },
      listener: ( context,state){},
    );
  }

}
