import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'food.g.dart';

@HiveType(typeId: 0)
class Food {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String author;
  @HiveField(3)
  String image;
  @HiveField(4)
  String description;
  @HiveField(5)
  bool isFavorite;
  @HiveField(6)
  int likeCount;

  Food(this.id, this.title, this.author, this.image, this.description,
      this.isFavorite, this.likeCount);

  String key() => id;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "author": author,
      "image": image,
      "description": description,
      "isFavorite": isFavorite,
      "likeCount": likeCount
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(map["id"], map["title"], map["author"], map["image"],
        map["description"], map["isFavorite"] == 1, map["likeCount"]);
  }
}
