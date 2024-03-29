import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appointmentsPage.dart';
import '../service/AppointmentService.dart';

class CircularGraphScreen extends StatefulWidget {
  @override
  _CircularGraphScreenState createState() => _CircularGraphScreenState();
}

class _CircularGraphScreenState extends State<CircularGraphScreen> {
  int daysRemaining = 0;

  @override
  void initState() {
    super.initState();
    _fetchDaysRemaining();
  }

  Future<int?> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    return userId;
  }

  Future<void> _fetchDaysRemaining() async {
    int? userId = await _getUserId();
    int days = await AppointmentService().getDaysRemainingForNextDonation(userId!);
    setState(() {
      daysRemaining = days;
    });
  }

  Future<void> _cancelDonation() async {
    int? userId = await _getUserId();

    try {
      bool success = await AppointmentService.cancelDonation(userId!);

      if (success) {
        _fetchDaysRemaining();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Doação Cancelada'),
              content: Text('Doação cancelada com sucesso!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentsPage(),
                      ),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to cancel donation.');
      }
    } catch (e) {
      print('Error canceling donation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Outer Circle
                Container(
                  width: 196,
                  height: 196,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFD64545), width: 3),
                  ),
                ),
                // Inner Circle
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFE8E8E8), width: 3),
                  ),
                ),
                // Days remaining
                Positioned(
                  top: 70, // Adjust this value to center the number and text inside the circle
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$daysRemaining dias',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Color(0xFFD64545),
                        ),
                      ),
                      Text(
                        'para a próx. doação',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xFFBDBDBD),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cancelDonation,
              child: Text('Cancelar Doação'),
            ),
          ],
        ),
      ),
    );
  }
}
