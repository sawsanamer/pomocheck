import 'package:flutter/material.dart';
import 'package:pomocheck/components/category_tile.dart';

class RandomCategoryCard extends StatelessWidget {
  final bool isChosen;
  RandomCategoryCard({this.isChosen});

  @override
  Widget build(BuildContext context) {
    return CategoryTile(
        icon: Icons.beach_access,
        iconColor: isChosen == null || isChosen == false
            ? Colors.blueAccent
            : Colors.blueAccent.withOpacity(0.4),
        containerColor: isChosen == null || isChosen == false
            ? Colors.lightGreenAccent
            : Colors.lightGreenAccent.withOpacity(0.4),
        title: "Random");
  }
}
