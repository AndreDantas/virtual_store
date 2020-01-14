import 'package:flutter/material.dart';
import 'package:virtual_store/data/category.dart';
import 'package:virtual_store/data/product.dart';
import 'package:virtual_store/helpers/category_tab_helper.dart';
import 'package:virtual_store/tiles/product_tile.dart';

class CategoryTab extends StatefulWidget {
  final Category category;

  CategoryTab(this.category);
  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  bool _gridMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.category.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: _gridMode ? Icon(Icons.list) : Icon(Icons.grid_on),
            onPressed: () {
              setState(() {
                _gridMode = !_gridMode;
              });
            },
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: getProductsFromCategory(this.widget.category),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasData) {
                if (_gridMode) {
                  return GridView.builder(
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.65),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        snapshot.data[index],
                        mode: ProductTile.MODE_GRID,
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        snapshot.data[index],
                        mode: ProductTile.MODE_LIST,
                      );
                    },
                  );
                }
              } else {
                return Center(
                  child: Text(
                    "Failed to load products.",
                    style: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
