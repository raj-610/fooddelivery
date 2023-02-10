import 'package:deliveryfood/constants/constants.dart';
import 'package:deliveryfood/entity/entity.dart';
import 'package:deliveryfood/screens/screens.dart';
import 'package:deliveryfood/cubits/cubits.dart';
import 'package:deliveryfood/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodsPage extends StatefulWidget {

  late Foods food;


  @override
  State<FoodsPage> createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  AuthService _authService = AuthService();

@override
void setState(VoidCallback fn) {
  if (FirebaseAuth.instance.currentUser != null) {
    print(FirebaseAuth.instance.currentUser?.displayName);
  }
  var username= FirebaseAuth.instance.currentUser?.displayName;
  var email= FirebaseAuth.instance.currentUser?.email;

  super.setState(fn);
}

@override
void initState() {

  super.initState();
  context.read<HomePageCubit>().getFoods();
  context.read<BasketPageCubit>().loadFoodInCart("${FirebaseAuth.instance.currentUser?.email}");
}

  int food_order_piece = 1;
  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Food",
          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Montserrat-Medium.ttf", color: kTextColorWhite,fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomePageCubit,List<Foods>>(
          builder: (context,FoodList){
            if(FoodList.isNotEmpty){
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 3),
                  itemCount: FoodList.length,
                  itemBuilder: (context,index){
                    var food = FoodList[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodDetailPage(food: food)));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 185,
                        height: 200,
                        child: Card(
                          color: kSecondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(Icons.radio_button_checked_rounded,
                                        color: kTextColorWhite),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:
                                    Icon(Icons.favorite_rounded, color: kTextColorWhite),
                                  ),
                                ],
                              ),
                              CircleAvatar(backgroundImage: NetworkImage(
                                  "http://kasimadalan.pe.hu/Food/resimler/${food.food_image_name}"),maxRadius: 60,backgroundColor: kPrimaryColor,),
                              SizedBox(height:5),
                              Text(
                                food.food_id,
                                style: TextStyle(color: kTextColorWhite,fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  //HIDDEN AddToCart button
                                  // Padding(
                                  //   padding: const EdgeInsets.all(10.0),
                                  //   child: IconButton(
                                  //
                                  //     onPressed: () {
                                  //
                                  //
                                  //       for (var i = 0; i < FoodList.length; i++) {
                                  //         if (widget.food.food_adi == FoodList[i].food_name) {
                                  //           count = 0;
                                  //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  //             duration: Duration(seconds: 1),
                                  //             content: Text("This Product Has Been Added To Cart"),
                                  //           ));
                                  //           return;
                                  //         }
                                  //       }
                                  //       if (count == 0) {
                                  //         context.read<FoodDetailPageCubit>().AddFood(widget.food.food_name, widget.food.food_image_name,
                                  //             int.parse(widget.food.food_price), food_order_piece, "${FirebaseAuth.instance.currentUser?.email}");
                                  //         count--;
                                  //
                                  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  //           duration: Duration(seconds: 2),
                                  //           content: Text("Product Added Successfully, Would You Like To Go To Cart?"),
                                  //           action: SnackBarAction(
                                  //             label: "Yes",
                                  //             onPressed: () {
                                  //               Navigator.push(context, MaterialPageRoute(builder: ((context) => BasketPage())));
                                  //             },
                                  //           ),
                                  //         ));
                                  //       } else {
                                  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  //           content: Text("This Product Is Already In The Cart!"),
                                  //         ));
                                  //       }
                                  //
                                  //     }, icon: Icon(Icons.add_circle,color: kPrimaryColor,),
                                  //   ),
                                  // ),
                                  Text("${food.food_price}.00 ₹",style: TextStyle(color: kTextColorWhite,fontFamily: "Roboto-Regular.ttf",fontSize: 18),)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              );
            }else{
              return const Center();
            }
          }
      ),
      floatingActionButton: floatingActions(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomNavigations(colors: kPrimaryColor,),
    );
  }
}
class bottomNavigations extends StatelessWidget {
  AuthService _authService = AuthService();
  final Color colors;

  bottomNavigations({required this.colors});

  @override
  Widget build(BuildContext context) {
    return  BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: colors,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authService.signOut();
              Navigator.pop(context);
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 40),
          //   child: IconButton(
          //     icon: Icon(Icons.person),
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePAge()));
          //     },
          //   ),
          // ),
          IconButton(
            icon: Icon(Icons.shopping_basket_rounded),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BasketPage()));
            },
          ),
        ],
      ),
    );
  }
}

class floatingActions extends StatelessWidget {
  const floatingActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodsPage()));},
      child: Icon(
        Icons.home,
        color: kTextColorWhite,
      ),
      backgroundColor: kTextColorDark,
    );
  }
}
