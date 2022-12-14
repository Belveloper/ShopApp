class ShopLogOutModel {
  bool? status;
  String? message;
  UserLogOutData? data;

  ShopLogOutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UserLogOutData.fromJson(json['data']);
  }
}

class UserLogOutData {
  int? id;
  String? token;
  UserLogOutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
  }
}
