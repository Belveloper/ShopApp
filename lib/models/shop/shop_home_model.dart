class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<dynamic>? banners = [];
  List<dynamic>? products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    //banners = json['banners'].forEach((element) {

    for (var element in json['banners']) {
      if (element != null) {
        print(element);
        banners?.add(element);
      }
    }
    // banners?.add(element);
    // print('banner added to the banners list');
    for (var element in json['products']) {
      if (element != null) {
        print(element);
        products?.add(element);
      }
    }
  }
}

class BnnerModel {
  int? id;
  String? image;
  BnnerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
