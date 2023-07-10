import 'package:flutter/material.dart';

class MenuComponent extends StatelessWidget {
  final List<String> menuItems;
  final Function(int) onItemSelected;

  MenuComponent({required this.menuItems, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white, // Defina a cor de fundo do menu
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          menuItems.length,
              (index) => GestureDetector(
            onTap: () {
              onItemSelected(index);
            },
            child: Container(
              width: 75,
              height: 24,
              alignment: Alignment.topCenter,
              child: Text(
                menuItems[index],
                style: TextStyle(
                  color: Colors.grey, // Defina a cor do texto do menu
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
