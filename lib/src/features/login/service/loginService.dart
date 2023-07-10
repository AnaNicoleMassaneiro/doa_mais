import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  Future<bool> login(String email, String password) async {
    final url = 'http://localhost:8080/login';
    final body = jsonEncode({
      'email': email,
      'password': password,
    });
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        // Login successful
        return true;
      } else {
        // Login failed
        return false;
      }
    } catch (error) {
      // Error during API call
      return false;
    }
  }
}
