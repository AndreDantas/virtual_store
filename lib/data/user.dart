import 'dart:convert';

import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String address;
  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.address,
  });

  User copyWith({
    String id,
    String name,
    String email,
    String address,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'User id: $id, name: $name, email: $email, address: $address';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.id == id &&
        o.name == name &&
        o.email == email &&
        o.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ address.hashCode;
  }
}
