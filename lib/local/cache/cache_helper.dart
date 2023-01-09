import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class CacheHelper {
  static init() {
    Hive.openBox('Local');
  }

  static final localDb = Hive.box('Local');

  static Future saveData({
    @required String? key,
    @required dynamic value,
  }) async =>
      localDb.put(key, value);

  static dynamic getData({@required String? key}) {
    return localDb.get(key);
  }

  static dynamic deleteData({@required String? key}) {
    return localDb.delete(key);
  }
  // static SharedPreferences? sharedPreferences;
  // static init() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   print(sharedPreferences);
  // }

  // static Future<bool?> saveData({
  //   @required String? key,
  //   @required dynamic value,
  // }) async {
  //   switch (value.runtimeType) {
  //     case String:
  //       return await sharedPreferences?.setString(key!, value);
  //     case bool:
  //       return await sharedPreferences?.setBool(key!, value);

  //     case int:
  //       return await sharedPreferences?.setInt(key!, value);

  //     default:
  //       return await sharedPreferences?.setDouble(key!, value);
  //   }
  // }

  // static dynamic getData({@required String? key}) {
  //   return sharedPreferences!.get(key!);
  // }
}
