import 'package:flutter/material.dart';
import '../menu/MenuComponent.dart';
import '../menu/TabBarComponent.dart';
import '../scheduling/schedulingPage.dart';
import 'components/ButtonPrimary.dart';
import 'components/TextComponent.dart';

class AppointmentsPage extends StatelessWidget {
  final List<String> menuItems = ['Item 1', 'Item 2', 'Item 3'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
        backgroundColor: Color(0xFFE24646),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: TextComponent(text: 'Você já pode doar!'),
                ),
                SizedBox(height: 20),
                Center(
                  child: ButtonPrimary(),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: TabBarComponent(),
          ),
        ],
      ),
    );
  }
}
