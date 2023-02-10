import 'package:deliveryfood/constants/constants.dart';
import 'package:deliveryfood/cubits/cubits.dart';
import 'package:deliveryfood/entity/entity.dart';
import 'package:deliveryfood/screens/basketpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class FoodDetailPage extends StatefulWidget {
  Foods food;
  FoodDetailPage({
    required this.food,
  });

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<BasketPageCubit>().loadFoodInCart("${FirebaseAuth.instance.currentUser?.email}");
  }

  int food_order_piece = 1;
  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_sharp),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            }),
        title:  Text("${widget.food.food_name.toUpperCase()}",
          style: TextStyle(fontFamily: "Montserrat-Bold.ttf",fontSize: 20,fontWeight: FontWeight.bold,),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
            ),
            Card(


                color: kPrimaryColor,
                shape: const CircleBorder(side: BorderSide(width: 400,color: kPrimaryColor,style: BorderStyle.solid)),

                child: Image.network(width: 200, height: 200, "http://kasimadalan.pe.hu/foodler/resimler/${widget.food.food_image_name}")),
            Container(
              height: 10,
            ),
            Text(
              "${widget.food.food_name}",
              style: TextStyle(fontFamily: "Montserrat-Medium.ttf",fontSize: 30,),
            ),
            Container(),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Fee :",style: TextStyle(fontFamily: "Montserrat-Medium.ttf",fontSize: 25,),),


                Text(
                  " ${widget.food.food_price} ₹",
                  style: TextStyle(fontFamily: "Montserrat-Bold.ttf",fontSize: 25,fontWeight: FontWeight.bold,color: kTextColorDark ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),

              child: Container(
                height: 40,
                width:150,
                color: kSecondaryColor,
                padding: EdgeInsets.all(5),


                child:SizedBox(
                  height: 40,
                  width: 150,

                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children:const [
                    Icon(Icons.download_rounded),

                    Text("piece Choose"),
                  ]),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 35,
                  color: kPrimaryColor,
                  onPressed: () {
                    setState(() {
                      if (food_order_piece == 1) {
                        return;
                      }
                      food_order_piece--;
                    });
                  },
                  icon: Icon(Icons.arrow_circle_down),
                ),
                Text(
                  "${food_order_piece}",
                  style: TextStyle(fontSize: 30),
                ),
                IconButton(
                  iconSize: 35,
                  color: kPrimaryColor,
                  onPressed: (() {
                    setState(() {
                      food_order_piece++;
                    });
                  }),
                  icon: Icon(Icons.arrow_circle_up),
                ),
              ],
            ),
            Container(
              height: 40,
            ),
            BlocBuilder<BasketPageCubit, List<FoodsInCart>>(builder: (context, foodList) {
              return ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(minimumSize: Size(300, 60), primary: kSecondaryColor),
                  onPressed: () {
                    for (var i = 0; i < foodList.length; i++) {
                      if (widget.food.food_name == foodList[i].food_name) {
                        count = 0;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("This Product Has Been Added To Cart"),
                        ));
                        return;
                      }
                    }
                    if (count == 0) {
                      context.read<FoodDetailPageCubit>().AddFood(widget.food.food_name, widget.food.food_image_name,
                          int.parse(widget.food.food_price), food_order_piece, "${FirebaseAuth.instance.currentUser?.email}");
                      count--;

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text("Product Added Successfully"),
                        action:

                        SnackBarAction(
                          label: "Go To Cart",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => BasketPage())));
                          },
                        ),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("This Product Is Already In The Cart!"),
                      ));
                    }
                  },
                  icon: Icon(Icons.shopping_bag_outlined),
                  label: Text("Add to Cart"));
            }),
          ],
        ),
      ),
    );
  }
}