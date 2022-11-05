import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'lang': 'en',
          }),
    );
  }

  static Future<Response> getData({
    @required String? url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token,
    };
    return await dio!.get(url!, queryParameters: query);
  }

  static Future<Response> postData({
    @required String? url,
    Map<String, dynamic>? query,
    String? token,
    @required Map<String, dynamic>? data,
  }) async {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'ar',
      'Authorization': token,
    };
    return await dio!.post(url as String, queryParameters: query, data: data);
  }
}
