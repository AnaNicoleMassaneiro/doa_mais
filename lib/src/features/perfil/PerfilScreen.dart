import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Doador/service/UserService.dart';
import '../menu/TabBarComponent.dart';
import 'EditarPerfilScreen.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final UserService _userService = UserService();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    _getUserId();
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
              // Implemente a ação para "Logout" aqui
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Adicione aqui o layout convertido que você tinha, por exemplo:
          Positioned(
            height: 245,
            left: -1,
            right: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD64545), // red
              ),
            ),
          ),

          // Ellipse 6
          Positioned(
            width: 158,
            height: 158,
            left: MediaQuery.of(context).size.width / 2 - 158 / 2 - 0.5,
            top: 128,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/your_image.png'), // Substitua pelo caminho da sua imagem
                ),
                border: Border.all(
                  color: Colors.white, // White
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
          Positioned(
            width: 272,
            height: 82,
            left: 52,
            top: 302,
            child: Column(
              children: [
                // Victoria Robertson
                Container(
                  width: 272,
                  height: 36,
                  child: Text(
                    'Victoria Robertson',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Colors.black, // Black
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    '3 doações! Parabéns você está salvando vidas',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black, // Black
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

      // ...

// Botão "Editar" abaixo do texto
      Positioned(
        bottom: 16,
        left: 16,
        right: 16,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditarPerfilScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFD64545),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(
            'Editar Perfil',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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
