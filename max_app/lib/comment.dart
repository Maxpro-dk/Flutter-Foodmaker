import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part "comment.g.dart";
@HiveType(typeId: 1) 
class Comment {
  @HiveField(0)
  String id;
  @HiveField(1)
  String foodId;
  @HiveField(2)
  String title;
  @HiveField(3)
  String content;
  Comment(this.foodId, this.title, this.content, this.id);
  String key() => id;
}
