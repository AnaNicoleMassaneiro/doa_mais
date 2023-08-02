import 'package:flutter/material.dart';
import '../Doador/doadorCardPage.dart';
import '../appointments/appointmentsPage.dart';

class TabBarComponent extends StatefulWidget {
  final int initialSelectedIndex;

  TabBarComponent({required this.initialSelectedIndex});

  @override
  _TabBarComponentState createState() => _TabBarComponentState();
}

class _TabBarComponentState extends State<TabBarComponent> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
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
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentsPage(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  color: selectedIndex == 0 ? Colors.red : Colors.grey,
                  size: 24,
                ),
                Text(
                  'Página inicial',
                  style: TextStyle(
                    color: selectedIndex == 0 ? Colors.red : Colors.grey,
                    height: 1.5,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoadorCardScreen(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: selectedIndex == 1 ? Colors.red : Colors.grey,
                  size: 24,
                ),
                Text(
                  'Cartão de Doador',
                  style: TextStyle(
                    color: selectedIndex == 1 ? Colors.red : Colors.grey,
                    height: 1.5,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 2;
              });
              // Implementar a navegação para a tela do perfil aqui
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: selectedIndex == 2 ? Colors.red : Colors.grey,
                  size: 24,
                ),
                Text(
                  'Perfil',
                  style: TextStyle(
                    color: selectedIndex == 2 ? Colors.red : Colors.grey,
                    height: 1.5,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
