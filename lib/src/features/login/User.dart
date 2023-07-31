import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final int id;
  final String name;
  final String cpf;
  final String password;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.cpf,
    required this.password,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      cpf: json['cpf'],
      password: json['password'],
      email: json['email'],
    );
  }
}