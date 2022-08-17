

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:newsapp/shared/cubit/cubit.dart';

import '../../models/ItemBarModel.dart';

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

Widget myDivider() => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
Widget ArticleItem(article)=>Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ConditionalBuilder(
        condition: article['urlToImage'].toString() != null ,
        fallback: (context)=>Center(child: CircularProgressIndicator(),),
        builder: (context)=>Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover
              )
          ),

        ),

      ),
      SizedBox(width:10),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text('${article['title']}' ,style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis
              ),maxLines: 4,)),
              Text(article['publishedAt'],style: TextStyle(color: Colors.grey)),
            ],),
        ),
      )
    ],
  ),
);
Widget conditionBuilder(List list)=>ConditionalBuilder(condition: list.length >0,
    builder: (context)=>ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => ArticleItem(list[index]), separatorBuilder: (context,index)=>myDivider(), itemCount: list.length),
    fallback:(context) =>Center(child: CircularProgressIndicator()));
