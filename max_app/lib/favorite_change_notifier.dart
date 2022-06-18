import 'package:flutter/foundation.dart';
import 'package:max_app/food.dart';
import 'package:max_app/food_db.dart';

class FavoriteChangeNotifier extends ChangeNotifier {
  Food _food;
  FavoriteChangeNotifier(this._food);

  bool get isFavorite => _food.isFavorite;

  int get likeCount => _food.likeCount;

  set isFavorite(bool isFavorite) {
    _food.isFavorite = isFavorite;

    _food.likeCount = isFavorite? likeCount+1:likeCount-1;
    FoodDb.instance.update(_food);
    notifyListeners();
  }
}
