import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:virtual_store/data/store.dart';

class StoreTile extends StatelessWidget {
  final Store store;
  StoreTile(
    this.store,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100.0,
            child: Image.network(
              store.image,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(store.name,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                Text(
                  store.address,
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  launch(
                      "https://www.google.com/maps/search/?api=1&query=${store.lat.toString()},${store.long.toString()}");
                },
                child: Text("View on map"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
              ),
              FlatButton(
                onPressed: () {},
                child: Text("Call"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
              ),
            ],
          )
        ],
      ),
    );
  }
}
