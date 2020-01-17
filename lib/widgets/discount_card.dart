import 'package:flutter/material.dart';
import 'package:virtual_store/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ExpansionTile(
          title: Text("Apply a coupon",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              )),
          leading: Icon(Icons.card_giftcard),
          trailing: Icon(Icons.add),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Your coupon"),
                initialValue: CartModel.of(context).couponCode ?? "",
                onFieldSubmitted: (coupon) {
                  CartModel.of(context).getCoupon(coupon).then((discount) {
                    if (discount != null) {
                      CartModel.of(context).setCoupon(coupon, discount);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Discount of $discount% applied!"),
                        backgroundColor: Theme.of(context).primaryColor,
                      ));
                    } else {
                      CartModel.of(context).setCoupon(null, 0);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Coupon not found."),
                        backgroundColor: Colors.redAccent,
                      ));
                    }
                  });
                },
              ),
            )
          ],
        ));
  }
}
