import 'package:flutter/material.dart';
import '../menu/TabBarComponent.dart';
import 'FullscreenDoadorCardScreen.dart';

class DoadorCardScreen extends StatefulWidget {
  @override
  _DoadorCardScreenState createState() => _DoadorCardScreenState();
}

class _DoadorCardScreenState extends State<DoadorCardScreen> {
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
      body: Container(
        padding: EdgeInsets.only(top: 20,left: 20, right: 20),
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullscreenDoadorCardScreen(),
                ),
              );
            },
            child: Container(
                padding: EdgeInsets.only(top: 20,left: 20, right: 20, bottom: 20),
                width: 400,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Nome: Gabriela Silva',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Tipo Sanguíneo: O+',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors
                              .white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'CPF: 123.456.789-00',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors
                              .white, // Preencha aqui com a cor do texto desejada
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Validade: 31/12/2025',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors
                              .white, // Preencha aqui com a cor do texto desejada
                        ),
                      ),
                    ],
                  ),
                ))),
      ),
      bottomNavigationBar: TabBarComponent(initialSelectedIndex: 1),
    );
  }
}
