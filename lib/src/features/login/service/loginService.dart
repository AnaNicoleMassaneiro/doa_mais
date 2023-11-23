import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../User.dart';

class LoginService {
  Future<User?> login(String email, String password) async {
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
        Map<String, dynamic> userData = jsonDecode(response.body);
        return User.fromJson(userData);
      } else {
        return null;
      }
    } catch (error) {
      // Error during API call
      throw Exception('Error during API call');
    }
  }
}

Future<void> saveLoginStatus(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}
