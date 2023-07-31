import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppointmentService {
  static Future<bool> scheduleAppointment({
    required int hemobancoId,
    required int userId,
    required DateTime date,
    required TimeOfDay time,
  }) async {

    try {
      final appointmentData = {
        'hemobancoId': hemobancoId,
        'userId': userId,
        'date': "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'time': "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
      };

      final response = await http.post(
        Uri.parse('http://localhost:8080/appointments'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(appointmentData),
      );

      if (response.statusCode == 201) {
        // Appointment successfully scheduled
        return true;
      } else {
        // Error in scheduling appointment
        return false;
      }
    } catch (e) {
      // Exception occurred while making the API call
      return false;
    }
  }
}
