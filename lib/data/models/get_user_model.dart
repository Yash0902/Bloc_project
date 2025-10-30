import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? image;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.image,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      image: json['image'] as String?,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': name,
      'email': email,
      'phone': phone,
      'password': password,
      'image': image,
    };
  }


  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? image,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone, password, image];
}

