import 'package:virtual_store/data/store.dart';
import 'package:virtual_store/repository/repository.dart';

Future<List<Store>> getStores() async {
  final docs = await getStoresFirebase();
  final stores = <Store>[];

  docs.documents.forEach((doc) {
    if (doc?.data != null) {
      final store = Store.fromMap(doc.data);
      store.id = doc.documentID;
      stores.add(store);
    }
  });

  return stores;
}
