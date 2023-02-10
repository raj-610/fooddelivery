import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveryfood/repository/foodsdao_repo.dart';

class FoodDetailPageCubit extends Cubit<void> {
  FoodDetailPageCubit() : super(0);

  var foodrepo = FoodsDaoRepository();

  Future<void> AddFood(
      String food_name,
      String food_image_name,
      int food_price,
      int food_order_piece,
      String username) async {
    await foodrepo.addToCart(
        food_name,
        food_image_name,
        food_price,
        food_order_piece,
        username);
  }
}
