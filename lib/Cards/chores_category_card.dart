import 'package:flutter/material.dart';
import 'package:pomocheck/components/category_tile.dart';

class ChoresCategoryCard extends StatelessWidget {
  final bool isChosen;
  ChoresCategoryCard({this.isChosen});

  @override
  Widget build(BuildContext context) {
    return CategoryTile(
        icon: Icons.home,
        iconColor: isChosen == null || isChosen == false
            ? Colors.orange
            : Colors.orange.withOpacity(0.4),
        containerColor: isChosen == null || isChosen == false
            ? Colors.red
            : Colors.red.withOpacity(0.4),
        title: "Chores");
  }
}
