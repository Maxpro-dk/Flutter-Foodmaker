import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:max_app/favorite_change_notifier.dart';
import 'package:max_app/favorite_widget.dart';
import 'package:max_app/food.dart';
import 'package:max_app/food_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FoodDetail extends StatelessWidget {
  final food;

  FoodDetail({Key? key, required this.food}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Column(
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
            ),
            FavoriteWidget()
          ],
        )
      ]),
    );

    Widget btnSection = Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent)
            ),
              onPressed: () {
                Navigator.pushNamed(context, "/comment");
              },
              child: _btnColumn(Colors.blueGrey, Icons.comment, "comment")),
          _btnColumn(Colors.blueGrey, Icons.share, "share")
        ],
      ),
    );

    Widget describeSection = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 32),
      child: Html(data: food.description),
    );
    // make sure that  you add the folder and image path to yaml file
    Widget image_one = Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Image.asset(
        "images/gombo.jpg",
      ),
    );

    Widget image_two = Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Image.network(
        "http://recettesafricaine.com/wp-content/uploads/2016/10/xsauce-gombo-29092013211515.jpg.pagespeed.ic_.N8wV06J7Xe.jpg",
      ),
    );

    Widget image_three = Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image:
            "http://recettesafricaine.com/wp-content/uploads/2016/10/xsauce-gombo-29092013211515.jpg.pagespeed.ic_.N8wV06J7Xe.jpg",
        height: 400,
        width: 400,
        fit: BoxFit.cover,
      ),
    );

    Widget image_with_cach = Container(
      height: 400,
      width: 400,
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
            height: 400,
            width: 400,
            fit: BoxFit.cover,
          )),
    );

    Widget image_with_load = Stack(
      children: [
        Container(
          height: 400,
          width: 400,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        image_three
      ],
    );

    Widget food_detail = ChangeNotifierProvider(
      create: (context) => FavoriteChangeNotifier(food),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(" Food maker"),
          ),
          body: ListView(
            children: [
              image_with_cach,
              titleSection,
              btnSection,
              describeSection
            ],
          )),
    );

    return food_detail;
  }

  Column _btnColumn(Color color, IconData icon, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Icon(
            icon,
            color: color,
          ),
          margin: EdgeInsets.only(bottom: 8),
        ),
        Text(
          label,
          style: TextStyle(color: color),
        )
      ],
    );
  }
}
