
class FoodsInCart {

  String basket_food_id; //food_id
  String food_name; //food_name
  String food_image_name; //food_img_name
  String food_price; //food_price
  String food_order_piece; //food_order_piece
  String username; //username
  FoodsInCart({
    required this.basket_food_id,
    required this.food_name,
    required this.food_image_name,
    required this.food_price,
    required this.food_order_piece,
    required this.username,
  });


  factory FoodsInCart.fromJson(Map<String, dynamic> json) {
    return FoodsInCart(
        basket_food_id: json["basket_food_id"] as String,
        food_name: json["food_name"] as String,
        food_image_name: json["food_image_name"] as String,
        food_price: json["food_price"] as String,
        food_order_piece: json["food_order_piece"] as String,
        username: json["username"] as String);
  }
}
