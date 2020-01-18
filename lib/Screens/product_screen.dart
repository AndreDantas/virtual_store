import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/Screens/login_screen.dart';
import 'package:virtual_store/data/cart_item.dart';
import 'package:virtual_store/data/product.dart';
import 'package:virtual_store/models/cart_model.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/cart_screen.dart';
import 'package:virtual_store/widgets/darken_background_loading.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String _size = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    if (this.widget.product == null) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final product = this.widget.product;
    final primaryColor = Theme.of(context).primaryColor;
    final sizeColor = Colors.grey[500];
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            product.name,
            maxLines: 1,
          ),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) => Stack(
            children: <Widget>[
              SafeArea(
                child: Scrollbar(
                  child: ListView(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 0.9,
                        child: Carousel(
                          images: product.images.map((url) {
                            return NetworkImage(url);
                          }).toList(),
                          dotSize: 6.0,
                          dotSpacing: 15.0,
                          dotBgColor: Colors.transparent,
                          dotColor: primaryColor,
                          autoplay: false,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              product.name,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                              maxLines: 3,
                            ),
                            Text(
                              "\$ ${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Size",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 34.0,
                              child: GridView(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: 0.5),
                                children: product.sizes
                                    .map((size) => GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (size == this._size)
                                                this._size = "";
                                              else
                                                this._size = size;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: size == this._size
                                                    ? primaryColor
                                                    : Colors.transparent,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                                border: Border.all(
                                                    width: 3.0,
                                                    color: size == this._size
                                                        ? primaryColor
                                                        : sizeColor)),
                                            width: 50.0,
                                            child: Text(
                                              size,
                                              style: TextStyle(
                                                  color: size == this._size
                                                      ? Colors.white
                                                      : sizeColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            SizedBox(
                              height: 44.0,
                              child: RaisedButton(
                                color: UserModel.of(context).isLoggedIn()
                                    ? Colors.green
                                    : Theme.of(context).primaryColor,
                                onPressed: this._size.isNotEmpty ||
                                        !UserModel.of(context).isLoggedIn()
                                    ? () {
                                        addToCart(product);
                                      }
                                    : null,
                                child: Text(
                                  UserModel.of(context).isLoggedIn()
                                      ? "Add to cart"
                                      : "Log in to purchase",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                textColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              product.description,
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              model.isLoading()
                  ? DarkenBackgroundLoading(
                      loadingColor: Theme.of(context).primaryColor,
                    )
                  : Container()
            ],
          ),
        ));
  }

  void addToCart(Product product) {
    if (UserModel.of(context).isLoggedIn()) {
      CartItem item = CartItem(productId: product.id, size: _size, quantity: 1);
      item.product = product;
      CartModel.of(context).addProduct(item, _onSuccess, _onFailed);
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Item added to cart"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: "VIEW",
        textColor: Colors.white,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CartScreen()));
        },
      ),
    ));
  }

  void _onFailed() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Failed to add item"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
