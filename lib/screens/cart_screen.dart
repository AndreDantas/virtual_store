import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/data/cart_item.dart';
import 'package:virtual_store/models/cart_model.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/login_screen.dart';
import 'package:virtual_store/tiles/cart_tile.dart';
import 'package:virtual_store/widgets/discount_card.dart';
import 'package:virtual_store/widgets/order_summary.dart';
import 'package:virtual_store/widgets/shipping_card.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("My cart"),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
              final itemCount = model.items.length ?? 0;
              return Text(
                "$itemCount ${itemCount == 1 ? 'ITEM' : 'ITEMS'}",
                style: TextStyle(fontSize: 17.0),
              );
            }),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading() && UserModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Log in to see your shopping cart",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (model.items == null || model.items.length == 0) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Your shopping cart is empty",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.items.map((product) {
                    return CartTile(
                      product,
                      onRemove: _onRemove,
                      onFailedToRemove: _onFailedToRemove,
                    );
                  }).toList(),
                ),
                DiscountCard(),
                ShippingCard(),
                OrderSummary(_onCompleteOrder)
              ],
            );
          }
        },
      ),
    );
  }

  _onCompleteOrder() {}

  _onRemove(CartItem item) {
    this._scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Item removed from cart"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: "UNDO",
            textColor: Colors.white,
            onPressed: () {
              CartModel.of(context).addProduct(item, () {}, _onFailedToRestore);
            },
          ),
        ));
  }

  _onFailedToRemove() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Failed to remove item"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

  _onFailedToRestore() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Failed to restore item"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
