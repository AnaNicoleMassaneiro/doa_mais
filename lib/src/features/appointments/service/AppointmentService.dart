import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentService {
  Future<int> getDaysRemainingForNextDonation(int userId) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/appointments/user/$userId/next-donation'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['timeRemainingDays'];
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

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

  static Future<bool> hasPendingAppointment(int userId) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/appointments/user/$userId'));
      if (response.statusCode == 200) {
        // Decode the response JSON
        final jsonResponse = jsonDecode(response.body);

        // Check if the response is a list and not empty
        if (jsonResponse != null && jsonResponse is List && jsonResponse.isNotEmpty) {
          return true;
        }
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error checking appointment status: $e');
    }

    // There is no pending appointment or an error occurred
    return false;
  }

  static Future<bool> cancelDonation(int userId) async {
    String url = 'http://localhost:8080/appointments/$userId';

    try {
      var response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
     return false;
    }
  }
}
