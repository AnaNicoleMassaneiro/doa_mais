import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  Future<Map<String, dynamic>?> fetchUserData(int userId) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/cardDetails/$userId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
