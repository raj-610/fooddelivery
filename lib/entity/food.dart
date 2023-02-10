class Foods {
  String food_id;//food_id
  String food_name;//food_name
  String food_image_name;//food_img_name
  String food_price;//food_price


  Foods({
    required this.food_id,
    required this.food_name,
    required this.food_image_name,
    required this.food_price
  });

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(
        food_id: json["food_id"] as String,
        food_name: json["food_name"] as String,
        food_image_name: json["food_image_name"] as String,
        food_price: json["food_price"] as String);
  }
}
