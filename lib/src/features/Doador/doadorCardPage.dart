import 'package:doa_mais/src/features/Doador/service/UserService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../menu/TabBarComponent.dart';
import 'FullscreenDoadorCardScreen.dart';
import 'model/UserDataCard.dart';
import 'package:intl/intl.dart';

class DoadorCardScreen extends StatefulWidget {
  @override
  _DoadorCardScreenState createState() => _DoadorCardScreenState();
}

class _DoadorCardScreenState extends State<DoadorCardScreen> {
  final UserService _userService = UserService();
  late final UserDataCard? userData;
  bool isLoading = true; // Adicione uma variável para controlar o indicador de carregamento

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
      isLoading = false; // Define isLoading como falso após o carregamento dos dados
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
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: isLoading
                          ? Center(
                        child: CircularProgressIndicator(), // Indicador de carregamento
                      )
                          : userData != null
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
                            'Validade: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(userData!.validity))}',
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
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        'gota_de_sangue.png',
                        width: 150,
                        height: 250,
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
