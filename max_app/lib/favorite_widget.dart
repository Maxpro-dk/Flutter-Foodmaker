import "package:flutter/material.dart";
import 'package:max_app/favorite_change_notifier.dart';
import 'package:provider/provider.dart';

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidget createState() {
    return _FavoriteWidget();
  }
}

class _FavoriteWidget extends State<FavoriteWidget> {
  bool _isFavorite = false;
  int _likeCount = 45;

  void _favorite(FavoriteChangeNotifier notifier) {
    setState(() {
      if (_isFavorite) {
        _isFavorite = !_isFavorite;
      
      } else {
        _isFavorite = !_isFavorite;
        
      }

      notifier.isFavorite = _isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    FavoriteChangeNotifier _notifier =
        Provider.of<FavoriteChangeNotifier>(context);
    _isFavorite = _notifier.isFavorite;
    
    return Row(
      children: [
        IconButton(
          onPressed: () => _favorite(_notifier),
          icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
          color: Colors.redAccent,
        ),
        Consumer<FavoriteChangeNotifier>(builder:((context, notifier, _) => Text("${notifier.likeCount}"))
        ),
       
      ],
    );
  }
}
