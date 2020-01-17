import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:virtual_store/data/cart_item.dart';

class Order {
  String id;
  final String clientId;
  final List<CartItem> products;
  final double productsPrice;
  final double shippingPrice;
  final double discountPrice;
  final double totalPrice;
  int status = 0;
  Order({
    this.id,
    @required this.clientId,
    @required this.products,
    @required this.productsPrice,
    @required this.shippingPrice,
    @required this.discountPrice,
    @required this.totalPrice,
    this.status,
  });

  Order copyWith({
    String id,
    String clientId,
    List<CartItem> products,
    double productsPrice,
    double shippingPrice,
    double discountPrice,
    double totalPrice,
    int status,
  }) {
    return Order(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      products: products ?? this.products,
      productsPrice: productsPrice ?? this.productsPrice,
      shippingPrice: shippingPrice ?? this.shippingPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'clientId': clientId,
      'products': products.map((x) => x.toMap()).toList(),
      'productsPrice': productsPrice,
      'shippingPrice': shippingPrice,
      'discountPrice': discountPrice,
      'totalPrice': totalPrice,
      'status': status,
    };
  }

  static Order fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      id: map['id'],
      clientId: map['clientId'],
      products:
          List<CartItem>.from(map['products']?.map((x) => CartItem.fromMap(x))),
      productsPrice: map['productsPrice'],
      shippingPrice: map['shippingPrice'],
      discountPrice: map['discountPrice'],
      totalPrice: map['totalPrice'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  static Order fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order id: $id, clientId: $clientId, products: $products, productsPrice: $productsPrice, shippingPrice: $shippingPrice, discountPrice: $discountPrice, totalPrice: $totalPrice, status: $status';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Order &&
        o.id == id &&
        o.clientId == clientId &&
        o.products == products &&
        o.productsPrice == productsPrice &&
        o.shippingPrice == shippingPrice &&
        o.discountPrice == discountPrice &&
        o.totalPrice == totalPrice &&
        o.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        clientId.hashCode ^
        products.hashCode ^
        productsPrice.hashCode ^
        shippingPrice.hashCode ^
        discountPrice.hashCode ^
        totalPrice.hashCode ^
        status.hashCode;
  }
}
