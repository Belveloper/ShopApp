class UpdateProfileModel {
  bool? status;
  String? message;
  ProfileUpdateDataModel? data;
  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = ProfileUpdateDataModel.fromJson(json['data']);
  }
}

class ProfileUpdateDataModel {
  String? name;
  String? email;
  String? phone;
  ProfileUpdateDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
}
