import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Food {
  String id;
  String title;
  String author;
  String image;
  String description;
  bool isFavorite;
  int likeCount;

  Food(this.id, this.title, this.author, this.image, this.description,
      this.isFavorite, this.likeCount);

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
    return  Food(map["id"], map["title"], map["author"], map["image"],
        map["description"], map["isFavorite"]==1, map["likeCount"]);
  }
}
