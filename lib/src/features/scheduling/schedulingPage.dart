import 'package:flutter/material.dart';

class SchedulingPage extends StatefulWidget {
  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamento'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Data do agendamento:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Selecionar Data'),
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
            ),
          ],
        ),
      ),
    );
  }
}
