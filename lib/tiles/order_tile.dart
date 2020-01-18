import 'package:flutter/material.dart';
import 'package:virtual_store/data/order.dart';
import 'package:virtual_store/helpers/orders_tab_helper.dart';

class OrderTile extends StatefulWidget {
  final Order order;

  OrderTile(this.order);
  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    final order = this.widget.order;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<Order>(
          stream: getOrderStatusStream(order.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              default:
                if (snapshot.hasData) {
                  final order = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Order code: ${order.id}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(_buildProductsText(order)),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "Order Status:",
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildCircle(
                              "1", "Preparation", order.status ?? 0, 1),
                          Container(
                            height: 1.0,
                            width: 40.0,
                            color: Colors.grey[500],
                          ),
                          _buildCircle(
                              "2", "Transportation", order.status ?? 0, 2),
                          Container(
                            height: 1.0,
                            width: 40.0,
                            color: Colors.grey[500],
                          ),
                          _buildCircle("3", "Delivery", order.status ?? 0, 3),
                        ],
                      )
                    ],
                  );
                } else {
                  return Container();
                }
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(Order order) {
    String text = "Description:\n\n";
    for (var cartItem in order.products) {
      text +=
          "${cartItem.quantity} x ${cartItem.product.name} (\$ ${cartItem.product.price.toStringAsFixed(2)}) \n";
    }
    text += "\n";
    text += "Discount: \$ ${order.discountPrice.toStringAsFixed(2)}\n";
    text += "Shipping: \$ ${order.shippingPrice.toStringAsFixed(2)}\n";
    text += "\n";
    text += "Total: \$ ${order.totalPrice.toStringAsFixed(2)}";

    return text;
  }

  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        SizedBox(
          height: 4.0,
        ),
        Text(subtitle)
      ],
    );
  }
}
