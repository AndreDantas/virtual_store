import 'package:flutter/material.dart';
import 'package:virtual_store/data/order.dart';
import 'package:virtual_store/helpers/orders_tab_helper.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/tiles/order_tile.dart';

import '../login_screen.dart';

class OrdersTab extends StatefulWidget {
  @override
  _OrdersTabState createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      final userId = UserModel.of(context).getUser().id;

      return FutureBuilder<List<Order>>(
          future: getUserOrders(userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return ListView(
                      children: snapshot.data
                          .map((order) => OrderTile(order))
                          .toList()
                          .reversed
                          .toList());
                } else {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.playlist_add_check,
                          size: 80.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "You don't have any orders.",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ]);
                }
            }
          });
    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.view_list,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Log in to see your orders",
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
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
    }
  }
}
