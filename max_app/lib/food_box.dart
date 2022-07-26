import 'dart:io';

import 'package:hive/hive.dart';
import 'package:max_app/comment.dart';
import 'package:max_app/food.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class FoodBox {
  static final FoodBox instance = FoodBox();
  static late Box box;

  static void init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(FoodAdapter());
    FoodBox.box = await Hive.openBox("foodeBox");
    var values = box.values;
    if(values == null || values.isEmpty){
      FoodBox.box.putAll(Map.fromIterable(generate(),key:(e) => e.key(),value:(e) => e ));
    }
  }


  static List<Food> generate() {
    stderr.writeln("cest");
    List<Food> foodList = [];
    for (int i = 0; i < 10; i++) {
      foodList.add(Food(
          Uuid().v1(),
          "Sauce de Gombo$i",
          "par Maxime DOSSOU",
          "http://recettesafricaine.com/wp-content/uploads/2016/10/xsauce-gombo-29092013211515.jpg.pagespeed.ic_.N8wV06J7Xe.jpg",
          "L’objectif de notre travail de fin d’étude est de réaliser un système de contrôle et de"
              "surveillance du trafic routier béninois par identification unique des automobiles avec la"
              "technologie d’identification par radiofréquence (RFID). Ce système s’inscrit dans le cadre de"
              "la digitalisation du domaine du transport et de la logistique. Ledit système peut être utilisé,"
              "d’une part, par le gouvernement pour le contrôle et la surveillance des automobiles afin"
              "d’assurer la sécurité routière et d’optimiser la gestion du parc automobile et, d’autre part, par"
              "les entreprises pour la gestion de leurs véhicules et parking. Pour la réalisation de ce système,"
              "nous allons ",
          false,
          i));
    }
    return foodList;
  }
}

class CommentBox {
  static final CommentBox instance = CommentBox();
  static late Box box;

  static void init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(CommentAdapter());
    FoodBox.box = await Hive.openBox("commentBox");
    var values = box.values;

  }



}
