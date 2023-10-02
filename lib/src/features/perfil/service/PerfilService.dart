import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/UserData.dart';

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
    final apiUrl = '$baseUrl/$userId';

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        body: json.encode(updatedUserData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true; // Atualização bem-sucedida
      } else {
        return false; // Falha na atualização
      }
    } catch (e) {
      return false; // Erro durante a chamada PUT
    }
  }


}