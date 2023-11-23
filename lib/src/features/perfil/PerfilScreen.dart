import 'package:doa_mais/src/features/perfil/service/PerfilService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './service/UserService.dart';
import '../menu/TabBarComponent.dart';
import 'EditarPerfilScreen.dart';
import 'Model/UserData.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final UserService _userService = UserService();
  final PerfilService _perfilService = PerfilService();
  bool isLoading = true;

  Map<String, dynamic>? userData;
  UserData? userDataModel;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    _getUserId();
    fetchUserDataFromApi();
  }

  Future<void> _logout() async {
    // Clear user data from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId'); // Remove the user ID or any other data you stored during login

    // Navigate to the login screen or any other screen you want after logout
    Navigator.pushReplacementNamed(context, '/login'); // Replace with your login screen route
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

  Future<void> fetchUserDataFromApi() async {
    int? userId = await _getUserId();

    try {
      final data = await _perfilService.fetchUserData(userId!);
      setState(() {
        userDataModel = data;
        isLoading = false; // Marca o carregamento como concluído
      });
    } catch (e) {
      // Trate erros aqui, como exibir uma mensagem de erro para o usuário.
      print('Erro ao buscar dados do usuário: $e');
      setState(() {
        isLoading = false; // Marca o carregamento como concluído, mesmo em caso de erro
      });
    }
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
        title: Text('Perfil do Doador'),
        backgroundColor: Color(0xFFE24646),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            },
          ),

        ],
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Stack(
        children: [
          Container(
            color: Color(0xFFD64545), // Cor de fundo vermelha
            height: 245,
          ),
          Positioned(
            width: 158,
            height: 158,
            left: MediaQuery.of(context).size.width / 2 - 158 / 2 - 0.5,
            top: 50, // Ajuste a posição vertical da foto na parte vermelha
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/your_image.jpeg'), // Substitua pelo caminho da sua imagem
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(79),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(101, 101, 101, 0.15),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 245), // Margem para a parte branca
              color: Colors.white, // Cor de fundo branca
              child: Column(
                children: [
                  Container(
                    width: 272,
                    height: 36,
                    child: Text(
                      userDataModel!.name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Text(
                      userDataModel!.cpf,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditarPerfilScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD64545), // Cor vermelha para o botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      'Editar Perfil',
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
          ),
        ],
      ),
      bottomNavigationBar: TabBarComponent(initialSelectedIndex: 3),
    );
  }
}
