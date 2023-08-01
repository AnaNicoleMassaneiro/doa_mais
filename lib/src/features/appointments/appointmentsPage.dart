import 'package:doa_mais/src/features/appointments/service/AppointmentService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../menu/TabBarComponent.dart';
import 'components/ButtonPrimary.dart';
import 'components/CircularGraphScreen.dart';
import 'components/TextComponent.dart';

class AppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final List<String> menuItems = ['Item 1', 'Item 2', 'Item 3'];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Fetch appointment status when the widget is first created
    _hasPendingAppointment();
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
                ],
              );
            }
          }
        },
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        child: TabBarComponent(),
      ),
    );
  }
}
