import 'package:dio/dio.dart';


class DioHelper{

  static late Dio dio;

  static init(){
    dio=Dio(BaseOptions(
   baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: false,
    ));
  }

   static Future<Response> getData({required String url,required Map<String,dynamic> query })async{
     return await dio.get(url, queryParameters: query,);
  }
  static Future<Response> getData2({required String url,required Map<String,dynamic> query })async{
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang': 'lan',
      'Authorization':'token'??''
    };
    return await dio.get(url, queryParameters: query,);
  }
}
