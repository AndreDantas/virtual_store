import 'package:flutter/material.dart';
import 'package:virtual_store/data/product.dart';

class ProductTile extends StatelessWidget {
  final String mode;
  final Product product;
  static const String MODE_GRID = "grid";
  static const String MODE_LIST = "list";
  ProductTile(this.product, {this.mode});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Card(
      child: mode == MODE_GRID
          ? _buildForGrid(context, product)
          : _buildForList(context, product),
    ));
  }

  Widget _buildForGrid(BuildContext context, Product product) {
    if (product == null) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.8,
          child: product.images != null && product.images.length > 0
              ? Image.network(
                  product.images[0],
                  fit: BoxFit.cover,
                )
              : null,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildForList(BuildContext context, Product product) {
    return Row();
  }
}
