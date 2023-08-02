import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullscreenDoadorCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Bloquear orientação para modo paisagem
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Voltar para a tela anterior quando a tela em tela cheia for clicada
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.red, // Cor vermelha para simular a carteirinha em tela cheia
          child: Center(
            child: Text(
              'Toque para voltar',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
