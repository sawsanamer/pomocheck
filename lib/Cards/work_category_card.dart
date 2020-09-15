import 'package:flutter/material.dart';
import 'package:pomocheck/components/category_tile.dart';

class WorkCategoryCard extends StatelessWidget {
  final bool isChosen;
  WorkCategoryCard({this.isChosen});

  @override
  Widget build(BuildContext context) {
    return CategoryTile(
        icon: Icons.work,
        iconColor: isChosen == null || isChosen
            ? Colors.greenAccent.withOpacity(0.4)
            : Colors.greenAccent,
        containerColor: isChosen == null || isChosen
            ? Colors.lightBlue.withOpacity(0.4)
            : Colors.lightBlue,
        title: "work");
  }
}
