import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/UserData.dart';


class UserService {
  Future<UserData?> fetchUserData(int userId) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/cardDetails/$userId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserData.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }


}
