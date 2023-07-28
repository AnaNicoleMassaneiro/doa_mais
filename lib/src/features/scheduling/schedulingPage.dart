import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../appointments/service/LocationService.dart';
import '../login/HemobancoAddress.dart';
import '../login/service/dateService.dart';
import '../menu/TabBarComponent.dart';

class SchedulingPage extends StatefulWidget {
  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? selectedLocation;
  List<String> locations = [];
  List<DateTime> availableDates = [];

  Future<void> _fetchAvailableDates() async {
    try {
      List<DateTime> dates = await DateService.fetchAvailableDates();
      setState(() {
        this.availableDates = dates;
      });
    } catch (e) {
      // Handle any errors that occurred during the API call.
      // You may show an error message or handle it based on your app's requirements.
      print('Error fetching available dates: $e');
    }
  }

  bool isDateAvailable(DateTime date) {
    return availableDates.contains(date);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) {
        // Check if the date is available in the availableDates list
        return isDateAvailable(date);
      },
    );

    if (pickedDate != null) {
      if (isDateAvailable(pickedDate)) {
        setState(() {
          selectedDate = pickedDate;
        });
      } else {
        // Show error message if the selected date is not available
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Date Not Available'),
              content: Text('The selected date is not available for scheduling.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
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
        Navigator.of(context).pop();
      },
    );
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecione o Local da Doação'),
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

  Future<void> _fetchLocations() async {
    try {
      List<HemobancoAddress> locations = await LocationService.fetchLocations();
      if (locations.isNotEmpty) {
        List<String> addresses = locations.map((location) => location.address).toList();
        setState(() {
          this.locations = addresses;
        });
      } else {
        // Handle the case where the API returns an empty list of locations.
        // You may show an error message or handle it based on your app's requirements.
      }
    } catch (e) {
      // Handle any errors that occurred during the API call.
      // You may show an error message or handle it based on your app's requirements.
      print('Error fetching locations: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLocations();
    _fetchAvailableDates();
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
                onPressed: () {
                  if (locations.isNotEmpty) {
                    _showLocationDialog();
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Locations Unavailable'),
                          content: Text('No locations available at the moment.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Selecionar Local'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE24646),
                  onPrimary: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              if (selectedLocation != null)
                Text(
                  'Local: $selectedLocation',
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
                  foregroundColor: Colors.white, backgroundColor: isDateAvailable(selectedDate) ? Colors.green : Color(0xFFE24646),
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
