import 'package:flutter/material.dart';
import 'package:pomocheck/components/category_tile.dart';

class FunCategoryCard extends StatelessWidget {
  final bool isChosen;
  FunCategoryCard({this.isChosen});

  @override
  Widget build(BuildContext context) {
    return CategoryTile(
        icon: Icons.queue_music,
        iconColor: isChosen == null || isChosen == false
            ? Colors.lightGreen
            : Colors.lightGreen.withOpacity(0.4),
        containerColor: isChosen == null || isChosen == false
            ? Colors.pinkAccent
            : Colors.pinkAccent.withOpacity(0.4),
        title: "Fun");
  }
}
