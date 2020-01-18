import 'dart:convert';
import 'package:virtual_store/data/product.dart';

class CartItem {
  String id;
  int quantity;
  String size;
  String productId;
  Product product;
  CartItem({
    this.id,
    this.quantity,
    this.size,
    this.productId,
    this.product,
  });

  CartItem copyWith({
    String id,
    int quantity,
    String size,
    String productId,
    Product product,
  }) {
    return CartItem(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      productId: productId ?? this.productId,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'quantity': quantity,
      'size': size,
      'productId': productId,
      'product': product?.toMap(),
    };
  }

  static CartItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CartItem(
      id: map['id'],
      quantity: map['quantity'],
      size: map['size'],
      productId: map['productId'],
      product: Product.fromMap(Map.from(map['product'])),
    );
  }

  String toJson() => json.encode(toMap());

  static CartItem fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartItem id: $id, quantity: $quantity, size: $size, productId: $productId, product: $product';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CartItem &&
        o.id == id &&
        o.quantity == quantity &&
        o.size == size &&
        o.productId == productId &&
        o.product == product;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        quantity.hashCode ^
        size.hashCode ^
        productId.hashCode ^
        product.hashCode;
  }
}
