import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_app/food.dart';
import 'package:max_app/food_db.dart';
import 'package:max_app/food_detail.dart';
import 'package:uuid/uuid.dart';

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
      body: FutureBuilder<List<Food>>(
        future: FoodDb.instance.foods(),
        builder: (BuildContext context, AsyncSnapshot<List<Food>> snapshot) {
          if (snapshot.hasData) {
            List<Food> foodList = snapshot.requireData;
            return Container(
                child: ListView.builder(
                    itemCount: foodList.length,
                    itemBuilder: (context, index) {
                      final thisFood = foodList[index];
                      return Dismissible(
                          key: Key(thisFood.title),
                          onDismissed: (direction) {
                            setState(() {
                              foodList.removeAt(index);
                              FoodDb.instance.delete(thisFood);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "${thisFood.title} supprimé avec succès")));
                          },
                          background: Container(
                            color: Color.fromARGB(116, 233, 134, 127),
                            margin: EdgeInsets.symmetric(vertical: 4),
                          ),
                          child: FoodItem(food: thisFood));
                    }));
          } else {
            return Center(child: Text("oh! aucune recette"));
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      food.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    food.author,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
