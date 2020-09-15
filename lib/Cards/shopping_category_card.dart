import 'package:flutter/material.dart';
import 'package:pomocheck/components/category_tile.dart';

class ShoppingCategoryCard extends StatelessWidget {
  final bool isChosen;
  ShoppingCategoryCard({this.isChosen});

  @override
  Widget build(BuildContext context) {
    return CategoryTile(
        icon: Icons.shopping_cart,
        iconColor: isChosen == null || isChosen == false
            ? Colors.orangeAccent
            : Colors.orangeAccent.withOpacity(0.4),
        containerColor: isChosen == null || isChosen == false
            ? Colors.yellow
            : Colors.yellow.withOpacity(0.4),
        title: "shopping");
  }
}
