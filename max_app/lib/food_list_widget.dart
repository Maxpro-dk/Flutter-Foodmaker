import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:max_app/food.dart';
import 'package:max_app/food_box.dart';

import 'package:hive_flutter/hive_flutter.dart';

class FoodListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FoodListWidget();
  }
}

class _FoodListWidget extends State<FoodListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des recettes"),
      ),
      body: ValueListenableBuilder(
        valueListenable: FoodBox.box.listenable(),
        builder: (context, Box items, _) {
          if (!items.isEmpty) {
            List<String> keys = items.keys.cast<String>().toList();
            return Container(
                child: ListView.builder(
                    itemCount: keys.length,
                    itemBuilder: (context, index) {
                      final Food thisFood = items.get(keys[index]);
                      return Dismissible(
                          key: Key(thisFood.title),
                          onDismissed: (direction) {
                            setState(() {
                              FoodBox.box.delete(thisFood.key());
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "${thisFood.title} supprimé avec succès")));
                          },
                          background: Container(
                            color:const Color.fromARGB(116, 233, 134, 127),
                            margin:const EdgeInsets.symmetric(vertical: 4),
                          ),
                          child: FoodItem(food: thisFood));
                    }));
          } else {
            return const Center(child: Text("oh! aucune recette"));
          }
        },
      ),
    );
  }
}

class FoodItem extends StatelessWidget {
  final Food food;
  FoodItem({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/food",
          arguments: food,
        );
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Hero(
                    tag: food.title,
                    child: CachedNetworkImage(
                      imageUrl: food.image,
                      placeholder: (context, url) {
                        return Container(
                          height: 400,
                          width: 400,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      height: 100,
                      width: 100,
                    )),
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Expanded(child: Text(
                      food.title,
                      
                      style: TextStyle(fontWeight: FontWeight.bold),
                      
                    )),
                  ),
                  Text(
                    food.author,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                ],
              ) )
             ,
            ],
          ),
        ),
      ),
    );
  }
}
