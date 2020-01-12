import 'package:cloud_firestore/cloud_firestore.dart';

const HOME = "home";
const POS = "pos";
const CATEGORIES = "categories";
const CATEGORIES_ID = "categoriesId";
const PRODUCTS = "products";

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
          .where(CATEGORIES_ID, isEqualTo: categoryId)
          .getDocuments();
}
