import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/Screens/login_screen.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/cart_screen.dart';
import 'package:virtual_store/tiles/drawer_tile.dart';

import '../extensions.dart';

class CustomDrawer extends StatelessWidget {
  final PageController _pageController;

  CustomDrawer(this._pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildGradient() => buildLinearGradient(colorRGB(203, 236, 241),
        Colors.white, Alignment.topCenter, Alignment.bottomCenter);

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildGradient(),
          ListView(
            padding: const EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(bottom: 8.0),
                padding:
                    const EdgeInsets.only(top: 16.0, right: 16.0, bottom: 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Flutter's\nClothing",
                        style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "Hello, ${!model.isLoggedIn() ? "" : model.getUser().name}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () {
                                !model.isLoggedIn()
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()))
                                    : model.signOut();
                              },
                              child: Text(
                                !model.isLoggedIn()
                                    ? "Login or create a account >"
                                    : "Log out",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Home", _pageController, 0),
              DrawerTile(Icons.local_offer, "Products", _pageController, 1),
              DrawerTile(Icons.location_on, "Stores", _pageController, 2),
              DrawerTile(
                  Icons.playlist_add_check, "My Orders", _pageController, 3),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  child: Container(
                    height: 60.0,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.shopping_cart,
                            size: 32.0, color: Colors.grey[700]),
                        SizedBox(
                          width: 32.0,
                        ),
                        Text(
                          "My Cart",
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[700]),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
