class ToggleFavouritesModel {
  bool? status;
  String? message;
 
  ToggleFavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

