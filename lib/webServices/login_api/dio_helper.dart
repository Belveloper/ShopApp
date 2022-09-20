import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'}));
  }

  static Future<Response> getData({
    @required String? url,
    @required Map<String, dynamic>? query,
  }) async {
    try {
      return dio.get(url.toString(), queryParameters: query);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<Response> postData({
    @required String? url,
    Map<String, dynamic>? query,
    @required Map<String, dynamic>? data,
  }) async {
    try {
      return dio.post(url.toString(), queryParameters: query, data: data);
    } catch (e) {
      throw e.toString();
    }
  }
}
