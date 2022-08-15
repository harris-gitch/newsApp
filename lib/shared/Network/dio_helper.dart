import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{

  static late Dio dio;

  static init(){
    dio=Dio(BaseOptions(
   baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: false,
    ));
  }
}
