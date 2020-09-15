import 'package:flutter/material.dart';
import 'package:pomocheck/components/category_tile.dart';

class UnspecifiedCategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CategoryTile(
        icon: Icons.help,
        iconColor: Colors.greenAccent[100],
        containerColor: Colors.amber[600],
        title: "Chores");
  }
}
