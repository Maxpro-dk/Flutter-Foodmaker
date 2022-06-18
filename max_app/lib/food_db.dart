import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:max_app/food.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:uuid/uuid.dart';

class FoodDb {
  FoodDb._();
  static final FoodDb instance = FoodDb._();
  final List<Food> _foodList = generate();

  static dynamic _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDb();

    return _database;
  }

  initDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(join(await getDatabasesPath(), "food_db.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE foods(id TEXT PRIMARY KEY,title TEXT,author TEXT,image TEXT,description TEXT,isFavorite INTEGER,likeCount INTEGER) ");
    }, version: 2);
  }

  void insert(Food food) async {
    stderr.writeln(_foodList.length);
    final Database db = await database;

    await db.insert("foods", food.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void update(Food food) async {
    final Database db = await database;

    await db.update("foods", food.toMap(),
        where: "id=?",
        whereArgs: [food.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void delete(Food food) async {
    final Database db = await database;

    await db.delete("foods", where: "id=?", whereArgs: [food.id]);
  }

  Future<List<Food>> foods() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('foods');
    List<Food> foods = List.generate(maps.length, (i) {
      return Food.fromMap(maps[i]);
    });

    if (foods.isEmpty) {
      for (Food food in _foodList) {
        insert(food);
      }

      foods = _foodList;
    }

    return foods;
  }

  static List<Food> generate() {
    stderr.writeln("cest");
    List<Food> foodList = [];
    for (int i = 0; i < 20; i++) {
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
