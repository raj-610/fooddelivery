import 'dart:convert';
import 'package:deliveryfood/entity/entity.dart';
import 'package:http/http.dart' as http;

class FoodsDaoRepository {
  List<Foods> parseFoodsResponse(String response) {
    return FoodResponse.fromJson(json.decode(response)).foods;
  }

  List<FoodsInCart> parseFoodsInCartResponse(String response) {
    return FoodsInCartResponse.fromJson(json.decode(response)).basket_foods;
  }

  Future<List<Foods>> getAllFoods() async {
    var url =
        Uri.parse("");
    var response = await http.get(url);
    return parseFoodsResponse(response.body);
  }

  Future<List<FoodsInCart>> getFoodsInCart(String username) async {
    var url = Uri.parse(
        "http://kasimadalan.pe.hu/foods/baskettekifoodsiGetir.php");
    var data = {"username": username};
    var response = await http.post(url, body: data);
    return parseFoodsInCartResponse(response.body);
  }

  Future<void> addToCart(String food_name, String food_image_name,
      int food_price, int food_order_piece, String username) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/foods/basketeYemekEkle.php");
    var data = {
      "food_name": food_name,
      "food_image_name": food_image_name,
      "food_price": food_price.toString(),
      "food_order_piece": food_order_piece.toString(),
      "username": username
    };

    var response = await http.post(url, body: data);
  }

  Future<void> removeFromCart(int basket_food_id, String username) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/foods/baskettenYemekSil.php");
    var data = {
      "basket_food_id": basket_food_id.toString(),
      "username": username
    };
    var response = await http.post(url, body: data);
  }
}
