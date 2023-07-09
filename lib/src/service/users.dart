import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> registerUser(String name, String cpf, String password, String email) async {
  final url = 'http://localhost:8080/users';

  final body = jsonEncode({
    'name': name,
    'cpf': cpf,
    'password': password,
    'email': email,
  });

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: body,
  );

  if (response.statusCode == 200) {
    print('Usuário registrado com sucesso');
  } else {
    print('Erro ao registrar usuário. Código de status: ${response.statusCode}');
    print('Mensagem de erro: ${response.body}');
  }
}
