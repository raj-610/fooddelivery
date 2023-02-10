import 'package:deliveryfood/entity/entity.dart';

class FoodResponse {
  List<Foods> foods; //foods list
  int success;

  FoodResponse({required this.foods, required this.success});

  factory FoodResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["foods"] as List;
    List<Foods> foodsListesi = jsonArray
        .map((jsonArrayObject) => Foods.fromJson(jsonArrayObject))
        .toList();
    int success = json["success"] as int;
    return FoodResponse(foods: foodsListesi, success: success);
  }
}
