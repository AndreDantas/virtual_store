import 'package:flutter/material.dart';
import 'package:virtual_store/helpers/products_tab_helper.dart';
import 'package:virtual_store/data/category.dart';

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
              return ListView();
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
