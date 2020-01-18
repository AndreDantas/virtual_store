import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Store {
  String id;
  String name;
  String image;
  String address;
  double lat;
  double long;
  Store({
    this.id,
    @required this.name,
    @required this.image,
    @required this.address,
    @required this.lat,
    @required this.long,
  });

  Store copyWith({
    String id,
    String name,
    String image,
    String address,
    double lat,
    double long,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'name': name,
      'image': image,
      'address': address,
      'lat': lat,
      'long': long,
    };
  }

  static Store fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Store(
      //id: map['id'],
      name: map['name'],
      image: map['image'],
      address: map['address'],
      lat: map['lat'],
      long: map['long'],
    );
  }

  String toJson() => json.encode(toMap());

  static Store fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Store id: $id, name: $name, image: $image, address: $address, lat: $lat, long: $long';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Store &&
        o.id == id &&
        o.name == name &&
        o.image == image &&
        o.address == address &&
        o.lat == lat &&
        o.long == long;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        address.hashCode ^
        lat.hashCode ^
        long.hashCode;
  }
}
