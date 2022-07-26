import 'dart:convert'; // Contains the JSON encoder

import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart';
import 'package:max_app/food.dart';
import 'package:max_app/food_box.dart';
import 'package:max_app/food_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

void scrap() async {
  int i;
  final pref = await SharedPreferences.getInstance();
  if (pref.getInt("page_number") != null) {
    i = pref.getInt("page_number") as int;
  } else {
    i = 1;
  }

  while (i < 100) {
    Response response = await Client().get(Uri.parse(
        "https://www.recettesafricaine.com/category/les-recettes-africaines/page/$i"));
    i++;
    try {
      if (scrapDoc(response)) print(i);
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      pref.setInt("page_number", i);
      break;
    }
  }
}

bool scrapDoc(Response response) {
  if (response.statusCode != 200) {
    return false;
  }

  var document = parse(response.body);

  List<Element> articles = document.getElementsByTagName('article');

  for (Element article in articles) {
    var docArticle = parse(article.innerHtml);

    late var image = docArticle.querySelector("img")?.attributes["src"];
    String imageStr = docArticle.querySelector("img")?.outerHtml as String;
    String? description = docArticle.querySelector(".entry-content")?.innerHtml;
    try {
      var foodTitle = docArticle.querySelector(".entry-title-link")?.text;
      var foodName = docArticle.querySelector(".entry-author-name")?.text;

      if (foodTitle == null ||
          foodName == null ||
          image == null ||
          description == null) {
        return false;
      }
      description = description.replaceAll(imageStr, "");

      Food food = Food(
          const Uuid().v1(), foodTitle, foodName, image, description, false, 2);
      print("ok");
      FoodBox.box.put(food.key(), food);
    } catch (e) {
      continue;
    }

    ;
  }

  return true;
}
