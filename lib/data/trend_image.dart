import 'dart:convert';

class TrendImage {
  final String imageUrl;
  final int x;
  final int y;

  TrendImage(
    this.imageUrl,
    this.x,
    this.y,
  );

  TrendImage copyWith({
    String imageUrl,
    int x,
    int y,
  }) {
    return TrendImage(
      imageUrl ?? this.imageUrl,
      x ?? this.x,
      y ?? this.y,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'x': x,
      'y': y,
    };
  }

  static TrendImage fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TrendImage(
      map['imageUrl'],
      map['x'],
      map['y'],
    );
  }

  String toJson() => json.encode(toMap());

  static TrendImage fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'TrendImage imageUrl: $imageUrl, x: $x, y: $y';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TrendImage && o.imageUrl == imageUrl && o.x == x && o.y == y;
  }

  @override
  int get hashCode => imageUrl.hashCode ^ x.hashCode ^ y.hashCode;
}
