import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

//Collections
const USERS = "users";
const CART = "cart";
const ORDERS = "orders";
const COUPONS = "coupons";
const HOME = "home";
const PRODUCTS = "products";
const CATEGORIES = "categories";

const CLIENT_ID = "clientId";
const ORDER_ID = "orderId";
const CATEGORY_ID = "categoryId";
const PRODUCTS_STORAGE_PATH = "Products";
const POS = "pos";

Future<QuerySnapshot> getTrendImagesFirebase() async {
  return await Firestore.instance.collection(HOME).orderBy(POS).getDocuments();
}

Future<QuerySnapshot> getCategoriesFirebase() async {
  return await Firestore.instance.collection(CATEGORIES).getDocuments();
}

Future<QuerySnapshot> getProductsFirebase({String categoryId}) async {
  return categoryId == null || categoryId.isEmpty
      ? await Firestore.instance.collection(PRODUCTS).getDocuments()
      : await Firestore.instance
          .collection(PRODUCTS)
          .where(CATEGORY_ID, isEqualTo: categoryId)
          .getDocuments();
}

Future<DocumentSnapshot> getProductFirebase(String productId) async {
  return await Firestore.instance
      .collection(PRODUCTS)
      .document(productId)
      .get();
}

Future<String> getProductImageUrlFirebase(String imageFile) async {
  final ref = FirebaseStorage.instance
      .ref()
      .child(PRODUCTS_STORAGE_PATH)
      .child(imageFile);
  return await ref.getDownloadURL() as String;
}

Future<DocumentReference> addCartItemFirebase(
    String userId, Map<String, dynamic> cartItemData) async {
  return await Firestore.instance
      .collection(USERS)
      .document(userId)
      .collection(CART)
      .add(cartItemData);
}

Future<bool> removeCartItemFirebase(String userId, String cartItemId) async {
  bool result = true;
  await Firestore.instance
      .collection(USERS)
      .document(userId)
      .collection(CART)
      .document(cartItemId)
      .delete()
      .catchError((e) {
    result = false;
  });

  return result;
}

Future<bool> updateCartItemDataFirebase(
    String userId, String cartItemId, Map<String, dynamic> cartItemData) async {
  bool result = true;
  await Firestore.instance
      .collection(USERS)
      .document(userId)
      .collection(CART)
      .document(cartItemId)
      .updateData(cartItemData)
      .catchError((e) {
    result = false;
  });

  return result;
}

Future<QuerySnapshot> getCartItemsFirebase(String userId) async {
  return await Firestore.instance
      .collection(USERS)
      .document(userId)
      .collection(CART)
      .getDocuments();
}

Future<DocumentReference> saveOrderFirebase(Map<String, dynamic> order) async {
  return await Firestore.instance.collection(ORDERS).add(order);
}

Future<DocumentSnapshot> getCouponFirebase(String couponName) async {
  return await Firestore.instance
      .collection(COUPONS)
      .document(couponName)
      .get();
}

Future<Null> saveUserOrderFirebase(String orderId, String userId) async {
  return await Firestore.instance
      .collection(USERS)
      .document(userId)
      .collection(ORDERS)
      .document(orderId)
      .setData({ORDER_ID: orderId});
}

Future<QuerySnapshot> getUserOrdersFirebase(String userId) async {
  return await Firestore.instance
      .collection(ORDERS)
      .where(CLIENT_ID, isEqualTo: userId)
      .getDocuments();
}

Future<Null> emptyUserCartFirebase(String userId) async {
  return await Firestore.instance
      .collection(USERS)
      .document(userId)
      .collection(CART)
      .getDocuments()
      .then((snapshot) {
    for (DocumentSnapshot doc in snapshot.documents) {
      doc.reference.delete();
    }
  });
}

Stream<DocumentSnapshot> getOrderStatusStreamFirebase(String orderId) {
  return Firestore.instance.collection(ORDERS).document(orderId).snapshots();
}
