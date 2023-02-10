import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deliveryfood/entity/food_cart.dart';
import 'package:deliveryfood/repository/foodsdao_repo.dart';

class BasketPageCubit extends Cubit<List<FoodsInCart>> {
  BasketPageCubit() : super(<FoodsInCart>[]);

  var foodrepo = FoodsDaoRepository();

  Future<void> loadFoodInCart(String Username,) async {
    var liste = await foodrepo.getFoodsInCart(Username);
    emit(liste);
  }

  Future<void> removeFood(int sepet_food_id, String Username) async {
    await foodrepo.removeFromCart(sepet_food_id, Username);
    await loadFoodInCart(Username);
  }
}
