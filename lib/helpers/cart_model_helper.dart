import 'package:virtual_store/data/cart_item.dart';
import 'package:virtual_store/data/order.dart';
import 'package:virtual_store/repository/repository.dart';

Future<String> addCartItem(String userId, CartItem item) async {
  final doc = await addCartItemFirebase(userId, item.toMap());
  if (doc == null) return null;
  return doc.documentID;
}

Future<bool> removeCartItem(String userId, CartItem item) async {
  return await removeCartItemFirebase(userId, item.id);
}

Future<List<CartItem>> getCartItems(String userId) async {
  final snapshot = await getCartItemsFirebase(userId);
  if (snapshot == null) return null;
  final List<CartItem> cartItems = [];
  snapshot.documents.forEach((doc) {
    final item = CartItem.fromMap(doc.data);
    item.id = doc.documentID;
    cartItems.add(item);
  });

  return cartItems;
}

Future<bool> updateCartItemData(String userId, CartItem cartItem) async {
  return await updateCartItemDataFirebase(
      userId, cartItem.id, cartItem.toMap());
}

Future<double> getCouponDiscount(String couponName) async {
  final doc = await getCouponFirebase(couponName);
  if (doc == null || doc.data == null) return null;
  return doc?.data["discount"] + 0.0;
}

Future<String> saveOrder(Order order) async {
  final docRef = await saveOrderFirebase(order.toMap());
  return docRef?.documentID;
}

Future<Null> saveUserOrder(String orderId, String userId) async {
  return await saveUserOrderFirebase(orderId, userId);
}

Future<Null> emptyUserCart(String userId) async {
  return await emptyUserCartFirebase(userId);
}
