import 'package:virtual_store/repository/repository.dart';
import 'package:virtual_store/data/trend_image.dart';

Future<List<TrendImage>> getTrendImages() async {
  final snapshot = await getTrendImagesFirebase();

  List<TrendImage> trendImages = [];
  snapshot.documents.forEach((doc) {
    trendImages.add(TrendImage(doc.data["image"],
        int.tryParse(doc.data["x"]) ?? 0, int.tryParse(doc.data["y"]) ?? 0));
  });
  return trendImages;
}
