import 'package:flutter/material.dart';

class CategoryTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color containerColor;
  final Color iconColor;
  CategoryTile({this.icon, this.title, this.containerColor, this.iconColor});

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
                color: widget.iconColor, fontFamily: 'Domine', fontSize: 13),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black87)),
            child: Icon(
              widget.icon,
              size: 85,
              color: widget.iconColor,
            ),
          ),
        ],
      ),
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black87),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            // shadow direction: bottom right
          )
        ],
        borderRadius: BorderRadius.circular(12),
        color: widget.containerColor,
      ),
    );
  }
}
