// @dart=2.9
import 'package:flutter/material.dart';
import 'package:max_app/food_list_widget.dart';
import 'package:max_app/route_generetor.dart';
import 'food_detail.dart';


void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "food maket",
        initialRoute: "/",
        onGenerateRoute: (settings)=>RouteGenerator.generate(settings) ,
        theme: ThemeData(primarySwatch: Colors.red),
        home: FoodListWidget());
  }
}
