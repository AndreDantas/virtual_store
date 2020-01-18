import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  final String orderId;
  OrderScreen(this.orderId);
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Complete"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
              size: 80.0,
            ),
            Text(
              "Successful purchase!",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Order tracking code: ${this.widget.orderId}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
