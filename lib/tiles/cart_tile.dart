import 'package:flutter/material.dart';
import 'package:virtual_store/data/cart_item.dart';
import 'package:virtual_store/data/product.dart';
import 'package:virtual_store/helpers/category_tab_helper.dart';
import 'package:virtual_store/models/cart_model.dart';

class CartTile extends StatefulWidget {
  final CartItem _cartItem;
  final void Function(CartItem) onRemove;
  final void Function() onFailedToRemove;

  CartTile(this._cartItem, {this.onRemove, this.onFailedToRemove});
  @override
  _CartTileState createState() => _CartTileState(_cartItem);
}

class _CartTileState extends State<CartTile> {
  final CartItem _cartItem;

  _CartTileState(this._cartItem);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: _cartItem.product == null
          ? FutureBuilder<Product>(
              future: getProduct(_cartItem.productId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Container(
                        height: 70.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor),
                        ));
                  default:
                    if (snapshot.hasData) {
                      _cartItem.product = snapshot.data;
                      CartModel.of(context).update();

                      return buildCartItem(context);
                    }
                    return Container(
                        height: 70.0,
                        alignment: Alignment.center,
                        child: Center(
                            child: Icon(
                          Icons.warning,
                          size: 60.0,
                        )));
                }
              },
            )
          : buildCartItem(context),
    );
  }

  Widget buildCartItem(BuildContext context) {
    final product = _cartItem.product;
    return Row(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(8.0),
            width: 100.0,
            child: Image.network(product?.images[0] ?? "")),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                ),
                Text(
                  "Size: ${_cartItem.size}",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  "\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Theme.of(context).primaryColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.remove),
                      onPressed: _cartItem.quantity > 1
                          ? () {
                              CartModel.of(context).decProduct(_cartItem);
                            }
                          : null,
                    ),
                    Text(
                      _cartItem.quantity.toString(),
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.add),
                      onPressed: () {
                        CartModel.of(context).incProduct(_cartItem);
                      },
                    ),
                    Expanded(
                      child: FlatButton(
                        child: Text("Remove"),
                        textColor: Colors.red[300],
                        onPressed: () {
                          CartModel.of(context).removeProduct(_cartItem,
                              onRemove: this.widget.onRemove,
                              onFailed: this.widget.onFailedToRemove);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
