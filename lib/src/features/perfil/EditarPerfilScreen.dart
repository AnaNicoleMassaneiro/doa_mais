import 'package:doa_mais/src/features/perfil/service/PerfilService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Doador/service/UserService.dart';
import '../menu/TabBarComponent.dart';

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
  final UserService _userService = UserService();
  Map<String, dynamic>? userData;

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
    int? userId = await _getUserId();

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
      userData = data;
    });
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
      "id": 1,
      "name": nameController.text,
      "password": passwordController.text,
    };

    final success = await _perfilService.updateUserData(1, updatedUserData);

    if (success) {
      _showModal('Sucesso', 'Perfil atualizado com sucesso', Colors.white);
    } else {
      _showModal('Erro', 'Falha ao atualizar o perfil do usuário', Colors.red);
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
      body: Stack(
        children: [
          // Phone Frame
          Positioned(
            top: -22,
            left: -22,
            child: Container(
              width: 419,
              height: 856,
              color: Colors.grey,
            ),
          ),

          // Silhouette
          Positioned(
            top: -22,
            left: -22,
            child: Container(
              width: 419,
              height: 856,
              color: Colors.white,
            ),
          ),

          // Notch
          Positioned(
            bottom: 8,
            left: MediaQuery.of(context).size.width / 2 - 135 / 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                width: 135,
                height: 5,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 44,
            child: Container(
              color: Colors.white,
            ),
          ),
          // Name Input
          Positioned(
            top: 250,
            left: 17,
            right: 15,
            height: 50,
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
          Positioned(
            top: 310,
            left: 17,
            right: 15,
            height: 50,
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

          // cpf Input
          Positioned(
            top: 370,
            left: 17,
            right: 15,
            height: 50,
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
          Positioned(
            top: 430,
            left: 17,
            right: 15,
            height: 50,
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

          Positioned(
            top: 490, // Altura para posicionar abaixo do campo de senha
            left: 17,
            right: 15,
            height: 50,
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

          Positioned(
            left: 17,
            right: 15,
            top: 580,
            height: 51,
            child: ElevatedButton(
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
          ),

          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 89 / 2,
            top: 190,
            child: Text(
              'Trocar Foto',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFFD64545),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 158 / 2 - 0.5,
            top: 20,
            child: Container(
              width: 158,
              height: 158,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(101, 101, 101, 0.15),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage('assets/your_image.png'), // Substitua pelo caminho da sua imagem
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TabBarComponent(initialSelectedIndex: 3),
    );
  }
}
