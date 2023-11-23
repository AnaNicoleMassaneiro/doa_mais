import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/UserData.dart';
import 'dart:io';

class PerfilService {
  final String baseUrl = 'http://localhost:8080/users';

  Future<UserData?> fetchUserData(int userId) async {
    final apiUrl = '$baseUrl/$userId';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserData.fromJson(data);
    } else {
      throw Exception('Falha ao buscar dados do usuário da API');
    }
  }

  Future<bool> updateUserData(int userId, Map<String, dynamic> updatedUserData) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:8080/users/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json', // Ensure the content type is set to JSON
        },
        body: jsonEncode(updatedUserData),
      );

      if (response.statusCode == 200) {
        // Handle the successful update here
        return true;
      } else {
        // Handle other status codes or errors
        return false;
      }
    } catch (e) {
      // Handle exceptions
      print('Error updating profile: $e');
      return false;
    }
  }



}