import 'package:flutter/material.dart';
import 'package:pomocheck/components/category_tile.dart';

class UniversityCategoryCard extends StatelessWidget {
  final bool isChosen;
  UniversityCategoryCard({this.isChosen});

  @override
  Widget build(BuildContext context) {
    return CategoryTile(
        icon: Icons.school,
        iconColor: isChosen == null || isChosen == false
            ? Colors.orange
            : Colors.orange.withOpacity(0.4),
        containerColor: isChosen == null || isChosen == false
            ? Colors.purple
            : Colors.purple.withOpacity(0.4),
        title: "university");
  }
}
