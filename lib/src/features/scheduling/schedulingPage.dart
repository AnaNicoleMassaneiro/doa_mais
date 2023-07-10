import 'package:flutter/material.dart';

import '../menu/MenuComponent.dart';
import '../menu/TabBarComponent.dart';

class SchedulingPage extends StatefulWidget {
  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? selectedLocation;

  List<String> locations = [
    'Location 1',
    'Location 2',
    'Location 3',
    'Location 4',
    'Location 5',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Widget _buildLocationItem(String location) {
    return ListTile(
      title: Text(location),
      onTap: () {
        setState(() {
          selectedLocation = location;
        });
      },
    );
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: locations.map((location) {
              return _buildLocationItem(location);
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

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
        title: Text('Agendamento'),
        backgroundColor: Color(0xFFE24646),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Local de Doação:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: _showLocationDialog,
                child: Text('Selecionar Local'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE24646),
                  onPrimary: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              if (selectedLocation != null)
                Text(
                  'Local selecionado: $selectedLocation',
                  style: TextStyle(fontSize: 16.0),
                ),
              SizedBox(height: 20.0),
              Text(
                'Data do agendamento:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Selecionar Data'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE24646),
                  onPrimary: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Data selecionada: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Horário do agendamento:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text('Selecionar Horário'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE24646),
                  onPrimary: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Horário selecionado: ${selectedTime.hour}:${selectedTime.minute}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Lógica para agendar o horário
                },
                child: Text('Agendar'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE24646),
                  onPrimary: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: TabBarComponent(),
    );
  }
}
