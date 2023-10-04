import 'dart:convert';
import 'package:http/http.dart' as http;

class UserDataCard {
  final int id;
  final String bloodType;
  final String cardNumber;
  final User user;
  final String validity;

  UserDataCard({
    required this.id,
    required this.bloodType,
    required this.cardNumber,
    required this.user,
    required this.validity,
  });

  factory UserDataCard.fromJson(Map<String, dynamic> json) {
    return UserDataCard(
      id: json['id'],
      bloodType: json['bloodType'],
      cardNumber: json['cardNumber'],
      user: User.fromJson(json['user']),
      validity: json['validity'],
    );
  }
}

class User {
  final String cpf;
  final String email;
  final int id;
  final String name;
  final String password;

  User({
    required this.cpf,
    required this.email,
    required this.id,
    required this.name,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      cpf: json['cpf'],
      email: json['email'],
      id: json['id'],
      name: json['name'],
      password: json['password'],
    );
  }
}


