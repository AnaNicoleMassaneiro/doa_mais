import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/UserDataCard.dart';

class UserService {
  Future<UserDataCard?> fetchUserData(int userId) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/cardDetails/$userId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserDataCard.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
