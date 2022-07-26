import 'package:flutter/material.dart';
import 'package:max_app/commen_widget.dart';
import 'package:max_app/food_detail.dart';
import 'package:max_app/food_list_widget.dart';

enum AppRoute { home, detail, error }

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => FoodListWidget());
        break;
      case "/food":
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                FoodDetail(food: settings.arguments),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInBack);
              return FadeTransition(opacity: animation, child: child);
            });

        case "/comment":
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CommentWidget(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInBack);
              return FadeTransition(opacity: animation, child: child);
            });

        break;

      default:
        return MaterialPageRoute(builder: ((context) => Scaffold(
          appBar: AppBar(title: const Text("Page erreur"),centerTitle: true,),
          body:Column(children: [  
             Center(child:  Text("Oups!! une erreur est survenue dans l'application. veuiller notifier à l'adresse",
              softWrap: false,
            
            ))
            ],),
        )));
    }
  }
}
