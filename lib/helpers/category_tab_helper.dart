import 'package:virtual_store/data/category.dart';
import 'package:virtual_store/repository/repository.dart';
import 'package:virtual_store/data/product.dart';

Future<List<Product>> getProductsFromCategory(Category category) async {
  final snapshot = await getProductsFirebase(categoryId: category?.id);
  List<Product> products = [];

  snapshot.documents.forEach((doc) {
    products.add(Product.fromMap(doc.data));
  });

  return products;
}
