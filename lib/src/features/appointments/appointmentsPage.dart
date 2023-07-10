import 'package:flutter/material.dart';

import '../scheduling/schedulingPage.dart';
import 'components/ButtonPrimary.dart';
import 'components/TextComponent.dart';

class AppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
        backgroundColor: Color(0xFFE24646),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextComponent(text: 'Você já pode doar!'),
            SizedBox(height: 20),
            ButtonPrimary(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}