import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/data/cart_item.dart';
import 'package:virtual_store/data/order.dart';
import 'package:virtual_store/helpers/cart_model_helper.dart';
import 'package:virtual_store/models/user_model.dart';

class CartModel extends Model {
  bool isLoading() => _loading;
  bool _loading = false;
  UserModel userModel;
  List<CartItem> items = [];
  String couponCode;
  double _discount;
  CartModel(this.userModel);

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  @override
  void addListener(listener) {
    super.addListener(listener);
    loadCartItems();
  }

  void setCoupon(String coupon, double discount) {
    couponCode = coupon;
    this._discount = discount;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }

  double getProductsPrice() {
    double price = 0.0;

    items.forEach((prod) {
      price += (prod.product?.price ?? 0.0) * prod.quantity;
    });
    return price;
  }

  double getShipping() {
    return 9.99;
  }

  double getDiscount() {
    return (getProductsPrice() -
            getProductsPrice() * (1 - (_discount ?? 0.0) / 100))
        .clamp(0.0, double.maxFinite);
  }

  void addProduct(CartItem item, void Function() onSuccess,
      void Function() onFailed) async {
    _startLoading();
    final itemId = await addCartItem(userModel.getUser().id, item);
    if (itemId != null) {
      item.id = itemId;
      this.items.add(item);
      if (onSuccess != null) onSuccess();
    } else {
      if (onFailed != null) onFailed();
    }
    _stopLoading();
  }

  void removeProduct(CartItem item,
      {void Function(CartItem item) onRemove, void Function() onFailed}) async {
    _startLoading();
    final success = await removeCartItem(userModel.getUser().id, item);
    if (success) {
      if (onRemove != null) onRemove(item);
      items.remove(item);
    } else {
      if (onFailed != null) onFailed();
    }
    _stopLoading();
  }

  void _startLoading() {
    _loading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _loading = false;
    notifyListeners();
  }

  void incProduct(CartItem product) {
    product.quantity++;

    updateCartItemData(userModel.getUser().id, product);

    notifyListeners();
  }

  void decProduct(CartItem product) {
    product.quantity--;
    if (product.quantity <= 0) product.quantity = 1;

    updateCartItemData(userModel.getUser().id, product);

    notifyListeners();
  }

  Future<Null> loadCartItems(
      {void Function() onSuccess, void Function() onFailed}) async {
    _startLoading();
    final user = userModel.getUser();
    if (user != null) {
      final cartItems = await getCartItems(user.id);
      if (cartItems == null) {
        if (onFailed != null) onFailed();
      } else {
        this.items = cartItems;
        if (onSuccess != null) onSuccess();
      }
    }
    _stopLoading();
  }

  Future<double> getCoupon(String couponName) async {
    return await getCouponDiscount(couponName);
  }

  double getOrderTotal() {
    if (items.length == 0) return 0.0;
    double productsPrice = getProductsPrice();
    double shipPrice = getShipping();
    double discount = this._discount ?? 0.0;
    return (productsPrice * (1 - discount / 100) + shipPrice)
        .clamp(0.0, double.maxFinite);
  }

  Future<String> finishOrder() async {
    if (items.length == 0 || !userModel.isLoggedIn()) return null;
    _startLoading();
    double total = getOrderTotal();
    double productPrices = getProductsPrice();
    double shipping = getShipping();
    double discount = getDiscount();
    final userId = userModel.getUser().id;
    final order = Order(
        clientId: userId,
        products: items,
        productsPrice: productPrices,
        discountPrice: discount,
        shippingPrice: shipping,
        totalPrice: total,
        status: 1);

    final orderId = await saveOrder(order);
    if (orderId != null) {
      order.id = orderId;
      items.clear();
      discount = null;
      couponCode = null;
      await emptyUserCart(userId);
      await saveUserOrder(orderId, userId);
    }

    _stopLoading();

    return orderId;
  }
}
