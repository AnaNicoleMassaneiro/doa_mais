import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:doa_mais/src/features/perfil/service/PerfilService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import './service/UserService.dart';
import '../menu/TabBarComponent.dart';
import 'package:permission_handler/permission_handler.dart';

class EditarPerfilScreen extends StatefulWidget {
  @override
  _EditarPerfilScreenState createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  final PerfilService _perfilService = PerfilService();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  File? _imageFile;

  final UserService _userService = UserService();
  Map<String, dynamic>? userData;
  int? userId = null;

  bool passwordsMatch = true;

  @override
  void initState() {
    super.initState();
    fetchUserDataFromApi();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    fetchUserData();
    _getUserId();
    super.dispose();
  }

  Future<void> fetchUserDataFromApi() async {
    userId = await _getUserId();

    try {
      final userData = await _perfilService.fetchUserData(userId!);

      // Preencha os controladores com os dados do usuário
      cpfController.text = userData!.cpf;
      nameController.text = userData.name;
      emailController.text = userData.email;
    } catch (e) {
      // Trate erros aqui, como exibir uma mensagem de erro para o usuário.
      print('Erro ao buscar dados do usuário da API: $e');
    }
  }

  Future<int?> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    return userId;
  }

  Future<void> fetchUserData() async {
    int? userId = await _getUserId();

    final data = await _userService.fetchUserData(userId!);
    setState(() {
      userData = data as Map<String, dynamic>?;
    });
  }

  Future<void> _pickImage() async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      try {
        final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
        if (imageFile != null) {
          // If permission is granted and an image is selected, continue.
          setState(() {
            _imageFile = File(imageFile.path);
          });
        } else {
          // Logic to handle the absence of a selected image.
        }
      } catch (e) {
        // Handle errors related to image picking.
        print('Error picking image: $e');
      }
    } else {
      // Logic to handle denied permission.
    }
  }

  Future<void> updateUserProfile() async {
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        passwordsMatch = false;
        _showModal('Erro', 'Senhas não coincidem', Colors.white);
      });
      return;
    }

    final updatedUserData = {
      "cpf": cpfController.text,
      "email": emailController.text,
      "id": userId,
      "name": nameController.text,
      "password": passwordController.text,
    };

    final success = await _perfilService.updateUserData(userId!, updatedUserData);

    if (success) {
      _showModal('Sucesso', 'Perfil atualizado com sucesso', Colors.white);
    } else {
      _showModal('Erro', 'Falha ao atualizar o perfil do usuário', Colors.red);
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

  void _showModal(String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          backgroundColor: color,
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Editar Perfil do Doador'),
        backgroundColor: Color(0xFFE24646),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  border: Border.all(color: Color(0xFFE8E8E8)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFBDBDBD),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Email Input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  border: Border.all(color: Color(0xFFE8E8E8)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFBDBDBD),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // CPF Input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  border: Border.all(color: Color(0xFFE8E8E8)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cpfController,
                          decoration: InputDecoration(
                            labelText: 'CPF',
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFBDBDBD),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Password Input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Color(0xFFF6F6F6),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFBDBDBD),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Implementar ação para mostrar/esconder a senha
                      },
                      child: Text(
                        'Mostrar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFD64545),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  border: Border.all(color: Color(0xFFE8E8E8)),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    // Adicione uma sombra vermelha se as senhas não coincidirem
                    if (!passwordsMatch)
                      BoxShadow(
                        color: Colors.red,
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirmar Senha',
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFBDBDBD),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: updateUserProfile,
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFD64545),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                'Salvar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TabBarComponent(initialSelectedIndex: 3),
    );
  }
}
