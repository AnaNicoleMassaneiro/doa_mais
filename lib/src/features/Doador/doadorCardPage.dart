import 'package:doa_mais/src/features/Doador/service/UserService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../menu/TabBarComponent.dart';
import 'FullscreenDoadorCardScreen.dart';
import 'model/UserDataCard.dart';

class DoadorCardScreen extends StatefulWidget {
  @override
  _DoadorCardScreenState createState() => _DoadorCardScreenState();
}

class _DoadorCardScreenState extends State<DoadorCardScreen> {
  final UserService _userService = UserService();
  late final UserDataCard? userData;

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
      userData = data as UserDataCard?;
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
        title: Text('Cartão de doador'),
        backgroundColor: Color(0xFFE24646),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FullscreenDoadorCardScreen(userData: userData!),
                  ),
                );
              },
              child: Container(
                width: 400,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  // Adiciona uma pilha para colocar a imagem em cima do container
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: userData != null
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Nome: ${userData!.user.name}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Tipo Sanguíneo: ${userData!.bloodType}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'CPF: ${userData!.user.cpf}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Validade: ${userData!.validity}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Número do cartão: ${userData!.cardNumber}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                          : Text(
                        'Carregando dados do usuário...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0, // Ajuste a posição vertical conforme necessário
                      right: 0, // Ajuste a posição horizontal conforme necessário
                      child: Image.asset(
                        'gota_de_sangue.png', // Substitua pelo caminho da sua imagem
                        width: 150, // Ajuste o tamanho conforme necessário
                        height: 250, // Ajuste o tamanho conforme necessário
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TabBarComponent(initialSelectedIndex: 1),
    );
  }
}
