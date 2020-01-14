import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

const HOME = "home";
const POS = "pos";
const CATEGORIES = "categories";
const CATEGORY_ID = "categoryId";
const PRODUCTS = "products";
const PRODUCTS_STORAGE_PATH = "Products";

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

Future<String> getProductImageUrlFirebase(String imageFile) async {
  final ref = FirebaseStorage.instance
      .ref()
      .child(PRODUCTS_STORAGE_PATH)
      .child(imageFile);
  return await ref.getDownloadURL() as String;
}
