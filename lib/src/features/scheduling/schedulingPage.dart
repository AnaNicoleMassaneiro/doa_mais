import 'package:doa_mais/src/features/scheduling/service/scheduleService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../appointments/service/AppointmentService.dart';
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
  int? selectedHemobancoId;
  List<HemobancoAddress> locations = [];
  List<DateTime> availableDates = [];
  String? selectedLocation;
  bool showDate = false;
  bool showTime = false;
  bool showScheduleButton = false;
  List<String> availableTimeSlots = [];
  bool isDateSelected = false;
  bool isTimeSelected = false;

  bool isDateAvailable(DateTime date) {
    return availableDates.contains(date);
  }

  DateTime getNextAvailableDate(DateTime currentDate) {
    for (DateTime date in availableDates) {
      if (date.isAfter(currentDate)) {
        return date;
      }
    }

    return currentDate;
  }

  Future<void> _scheduleAppointment() async {
    if (selectedLocation != null && isDateSelected && isTimeSelected) {
      try {
        int? userId = await _getUserId();

        if (userId != null) {
          bool success = await AppointmentService.scheduleAppointment(
            hemobancoId: selectedHemobancoId!,
            userId: userId,
            date: selectedDate,
            time: selectedTime,
          );

          if (success) {
            // Show success modal dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Successo'),
                  content: Text('Doação agendada com sucesso.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        Navigator.of(context).pop(); // Return to the previous screen
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            // Show error message if the appointment was not scheduled successfully
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Failed to schedule appointment.'),
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
        } else {
          // Handle the case when the user ID is null
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('User ID is null.'),
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

      } catch (e) {
        // Exception occurred while making the API call
        // You can show an error message or handle it based on your app's requirements
        print('Error scheduling appointment: $e');
      }
    } else {
      // Show an error message that all fields are required before scheduling the appointment
    }
  }


  void _showErrorModal(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
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

  void _showSuccessModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Doação agendada'),
          content: Text('Seu agendamento foi agendado com sucesso.'),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: getNextAvailableDate(selectedDate),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      selectableDayPredicate: _isDateSelectable,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Define the text color for selectable days
            primaryColor: Colors.red,
            // Define the text color for the header of the date picker
            hintColor: Colors.red,
            // Define the color for the "Today" text
            colorScheme: ColorScheme.light(primary: Colors.red),
            // Define the text color for the "Today" day
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        availableTimeSlots.clear();
        isDateSelected = true;// Clear the list when a new date is selected
      });

      // Fetch available time slots for the selected date
      String formattedDate = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      List<String> timeSlots = await DateService.fetchAvailableTimeSlotsForDate(selectedHemobancoId!, formattedDate);

      setState(() {
        availableTimeSlots = timeSlots;
      });
    }
  }

  Widget _buildTimeSlotItem(String timeSlot) {
    return ListTile(
      title: Text(timeSlot),
      // Add any functionality you want when a time slot is selected
      onTap: () {},
    );
  }


  bool _isDateSelectable(DateTime date) {
    return isDateAvailable(date);
  }


  Future<void> _fetchAvailableDatesForHemobanco(int hemobancoId) async {
    try {
      List<DateTime> dates = await DateService.fetchAvailableDatesForLocation(hemobancoId);

      setState(() {
        this.availableDates = dates;
      });
    } catch (e) {
      print('Error fetching available dates for Hemobanco: $e');
    }
  }

  void _showLocationDialog() {
    setState(() {
      selectedDate = DateTime.now();
      selectedTime = TimeOfDay.now();
      showDate = false;
      showTime = false;
      showScheduleButton = false;
    });
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
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    ).then((value) {
      // Update visibility of date, time, and schedule button based on location selection
      if (selectedLocation != null) {
        setState(() {
          showDate = true;
          showTime = true;
          showScheduleButton = true;
        });
      }
    });
  }

  Future<void> _fetchLocations() async {
    try {
      List<HemobancoAddress> locations = await LocationService.fetchLocations();
      if (locations.isNotEmpty) {
        List<HemobancoAddress> addresses = locations.map((location) => location).toList();
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

  Widget _buildLocationItem(HemobancoAddress location) {
    return ListTile(
      title: Text(location.address),
      onTap: () async {
        setState(() {
          selectedLocation = location.address;
        });
        Navigator.of(context).pop();

        if (location.id != null) {
          // Use the LocationService to fetch the Hemobanco by name
          HemobancoAddress locationDetails = await LocationService.fetchLocationByName(location.id!);

          setState(() {
            selectedHemobancoId = locationDetails.id;
          });

          // Fetch available dates for the selected Hemobanco
          await _fetchAvailableDatesForHemobanco(locationDetails.id!);
        } else {
          // Handle the case when the ID is null (optional based on your app's requirements).
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Location ID Missing'),
                content: Text('The selected location does not have an ID.'),
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
    );
  }

  Future<int?> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    return userId;
  }

  @override
  void initState() {
    super.initState();
    _fetchLocations();

    _getUserId().then((userId) {
      if (userId != null) {
        print('User ID: $userId');
      } else {
        print('User ID not found.');
      }
    });
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
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0),
                Text(
                  'Local de Doação:',
                  style: TextStyle(fontSize: 16.0),
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
                            title: Text('Locais indisponíveis'),
                            content: Text('Nenhum local disponível no momento.'),
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
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    textStyle: TextStyle(fontSize: 16.0),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFE24646),
                  ),
                ),
                SizedBox(height: 20.0),
                if (selectedLocation != null)
                  Text(
                    'Local: $selectedLocation',
                    style: TextStyle(fontSize: 16.0),
                  ),
                SizedBox(height: 30.0),
                if (selectedLocation != null)
                  Text(
                    'Data do agendamento:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                if (selectedLocation != null)
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Selecionar Data'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      textStyle: TextStyle(fontSize: 16.0),
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFE24646),
                    ),
                  ),
                SizedBox(height: 10.0),
                if (isDateSelected) // Mostrar texto de data selecionada somente se houver data selecionada
                  Text(
                    'Data selecionada: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                if (availableTimeSlots.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        'Horários disponíveis:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        children: availableTimeSlots.map((timeSlot) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedTime = TimeOfDay(
                                    hour: int.parse(timeSlot.split(':')[0]),
                                    minute: int.parse(timeSlot.split(':')[1]),
                                  );
                                  isTimeSelected = true;
                                });
                              },
                              child: Text(timeSlot),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                                textStyle: TextStyle(fontSize: 16.0),
                                primary: Colors.redAccent,
                                onPrimary: Colors.white,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                SizedBox(height: 30.0),
                if (isTimeSelected)
                  Text(
                    'Horário selecionado: ${selectedTime.hour}:${selectedTime.minute}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                SizedBox(height: 30.0),
                if (isTimeSelected)
                  ElevatedButton(
                    onPressed: _scheduleAppointment, // Call the _scheduleAppointment method when the button is clicked
                    child: Text('Agendar'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: TextStyle(fontSize: 16.0),
                      primary: Color(0xFFE24646),
                      onPrimary: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: TabBarComponent(),
    );
  }
}