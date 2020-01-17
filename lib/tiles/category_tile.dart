import 'package:flutter/material.dart';
import 'package:virtual_store/screens/category_screen.dart';
import 'package:virtual_store/data/category.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  CategoryTile(this.category);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(category.iconUrl),
      ),
      title: Text(category.title),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CategoryScreen(category)));
      },
    );
  }
}
