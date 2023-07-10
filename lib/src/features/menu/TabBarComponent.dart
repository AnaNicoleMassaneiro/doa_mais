import 'package:flutter/material.dart';

class TabBarComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white, // Cor de fundo branca
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, -4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Text(
            'Página inicial',
            style: TextStyle(
              color: Colors.red, // Cor do texto vermelha
              height: 1.5,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),

          Text(
            'Consultar exames',
            style: TextStyle(
              color: Colors.grey, // Cor do texto cinza escuro
              height: 1.5,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'Perfil',
            style: TextStyle(
              color: Colors.grey, // Cor do texto cinza escuro
              height: 1.5,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
