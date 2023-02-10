import 'package:deliveryfood/entity/entity.dart';

class FoodsInCartResponse {
  List<FoodsInCart> basket_foods; //foodsincart
  int success;

  FoodsInCartResponse({required this.basket_foods, required this.success});

  factory FoodsInCartResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["basket_foods"] as List;
    List<FoodsInCart> basketDishes =
        jsonArray.map((object) => FoodsInCart.fromJson(object)).toList();

    return FoodsInCartResponse(
        basket_foods: basketDishes, success: json["success"] as int);
  }
}
