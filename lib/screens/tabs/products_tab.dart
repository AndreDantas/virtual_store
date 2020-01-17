import 'package:flutter/material.dart';
import 'package:virtual_store/helpers/products_tab_helper.dart';
import 'package:virtual_store/data/category.dart';
import 'package:virtual_store/tiles/category_tile.dart';

class ProductsTab extends StatefulWidget {
  @override
  _ProductsTabState createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: getCategories(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasData) {
              var dividedTiles = ListTile.divideTiles(
                      tiles: snapshot.data
                          .map((category) => CategoryTile(category))
                          .toList(),
                      color: Colors.grey[500])
                  .toList();
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: ListView(
                  children: dividedTiles,
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Failed to load categories.",
                  style: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
                ),
              );
            }
        }
      },
    );
  }
}
