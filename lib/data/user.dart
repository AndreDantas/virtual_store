import 'dart:convert';

import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String name;
  final String address;
  User({
    @required this.id,
    @required this.name,
    @required this.address,
  });

  User copyWith({
    String id,
    String name,
    String address,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      name: map['name'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'User id: $id, name: $name, address: $address';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User && o.id == id && o.name == name && o.address == address;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ address.hashCode;
}
