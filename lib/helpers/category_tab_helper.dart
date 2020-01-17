import 'package:virtual_store/data/category.dart';
import 'package:virtual_store/repository/repository.dart';
import 'package:virtual_store/data/product.dart';

Future<List<Product>> getProductsFromCategory(Category category) async {
  final snapshot = await getProductsFirebase(categoryId: category?.id);
  List<Product> products = [];

  snapshot.documents.forEach((doc) {
    Product p = Product.fromMap(doc.data);
    p.id = doc.documentID;
    products.add(p);
  });

  return products;
}

Future<Product> getProduct(String productId) async {
  final doc = await getProductFirebase(productId);
  if (doc == null) return null;
  Product p = Product.fromMap(doc.data);
  p.id = doc.documentID;
  return p;
}
