import 'package:virtual_store/repository/repository.dart';
import 'package:virtual_store/data/category.dart';

Future<List<Category>> getCategories() async {
  final snapshot = await getCategoriesFirebase();

  List<Category> categories = [];
  snapshot.documents.forEach((doc) {
    categories
        .add(Category(doc.data["title"], doc.data["icon"], doc.documentID));
  });
  return categories;
}
