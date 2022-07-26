// @dart=2.9
import 'package:flutter/material.dart';
import 'package:max_app/food_box.dart';
import 'package:max_app/food_list_widget.dart';
import 'package:max_app/route_generetor.dart';
import 'package:max_app/scraping.dart';
import 'food_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FoodBox.init();

  runApp(MyApp());
  await scrap();
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "food maket",
        initialRoute: "/",
        onGenerateRoute: (settings) => RouteGenerator.generate(settings),
        theme: ThemeData(primarySwatch: Colors.red),
        home: FoodListWidget());
  }
}
