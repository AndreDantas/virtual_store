import 'dart:convert';

class Product {
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final List<String> sizes;
  final String categoryId;
  String id;
  Product({
    this.name,
    this.description,
    this.price,
    this.images,
    this.sizes,
    this.categoryId,
    this.id,
  });

  Product copyWith({
    String name,
    String description,
    double price,
    List<String> images,
    List<String> sizes,
    String categoryId,
    String id,
  }) {
    return Product(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
      categoryId: categoryId ?? this.categoryId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'images': List<dynamic>.from(images.map((x) => x)),
      'sizes': List<dynamic>.from(sizes.map((x) => x)),
      'categoryId': categoryId,
      'id': id,
    };
  }

  Map<String, dynamic> toResumedMap() {
    return {
      //'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      name: map['name'],
      description: map['description'],
      price: map['price'],
      images: map['images'] != null ? List<String>.from(map['images']) : [""],
      sizes: map['sizes'] != null ? List<String>.from(map['sizes']) : [""],
      categoryId: map['categoryId'],
      //id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  static Product fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product name: $name, description: $description, price: $price, images: $images, sizes: $sizes, categoryId: $categoryId, id: $id';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product &&
        o.name == name &&
        o.description == description &&
        o.price == price &&
        o.images == images &&
        o.sizes == sizes &&
        o.categoryId == categoryId &&
        o.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        images.hashCode ^
        sizes.hashCode ^
        categoryId.hashCode ^
        id.hashCode;
  }
}
