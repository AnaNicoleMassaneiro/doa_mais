import 'package:flutter/material.dart';
import '../menu/TabBarComponent.dart';
import 'components/ButtonPrimary.dart';
import 'components/CircularGraphScreen.dart';
import 'components/TextComponent.dart';
import 'components/appointment_card.dart';
import '../appointments/service/AppointmentService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _hasPendingAppointment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
        backgroundColor: Color(0xFFE24646),
      ),
      body: FutureBuilder<bool>(
        future: _hasPendingAppointment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error checking appointment status.'),
            );
          } else {
            bool hasAppointment = snapshot.data ?? false;

            if (hasAppointment) {
              return CircularGraphScreen();
            } else {
              return Column(
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
                  // Adjusted the height of the card using Expanded widget
                  AppointmentCard(),
                ],
              );
            }
          }
        },
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        child: TabBarComponent(initialSelectedIndex: 0),
      ),
    );
  }

  Future<int?> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    return userId;
  }

  Future<bool> _hasPendingAppointment() async {
    int? userId = await _getUserId();

    return AppointmentService.hasPendingAppointment(userId!);
  }
}
