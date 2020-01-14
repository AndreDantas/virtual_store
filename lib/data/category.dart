import 'dart:convert';

class Category {
  final String title;
  final String iconUrl;
  final String id;
  Category(
    this.title,
    this.iconUrl,
    this.id,
  );

  Category copyWith({
    String title,
    String iconUrl,
    String id,
  }) {
    return Category(
      title ?? this.title,
      iconUrl ?? this.iconUrl,
      id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'iconUrl': iconUrl,
      'id': id,
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Category(
      map['title'],
      map['iconUrl'],
      map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  static Category fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Category title: $title, iconUrl: $iconUrl, id: $id';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Category &&
        o.title == title &&
        o.iconUrl == iconUrl &&
        o.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ iconUrl.hashCode ^ id.hashCode;
}
