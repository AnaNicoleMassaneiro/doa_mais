import 'dart:convert';
import 'package:http/http.dart' as http;

class DateService {
  static Future<List<DateTime>> fetchAvailableDatesForLocation(int hemobancoId) async {
    final response = await http.get(Uri.parse('http://localhost:8080/hemobanco_dates/hemobanco/$hemobancoId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData is List<dynamic> && jsonData.isNotEmpty) {
        List<DateTime> dates = [];

        for (var item in jsonData) {
          final availableDates = item['availableDates'];

          if (availableDates is List<dynamic> && availableDates.isNotEmpty) {
            for (var dateData in availableDates) {
              // Assuming that the dates are stored as strings in the format 'YYYY-MM-DD'
              DateTime date = DateTime.parse(dateData['date']);
              dates.add(date);
            }
          }
        }

        if (dates.isNotEmpty) {
          return dates;
        }
      }

      throw Exception('Failed to fetch available dates for location');
    } else {
      throw Exception('Failed to fetch available dates for location');
    }
  }

  static Future<List<String>> fetchAvailableTimeSlotsForDate(int hemobancoId, String selectedDate) async {
    final response = await http.get(Uri.parse('http://localhost:8080/hemobanco_dates/hemobanco/$hemobancoId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData is List<dynamic> && jsonData.isNotEmpty) {
        List<String> timeSlots = [];

        for (var item in jsonData) {
          final availableDates = item['availableDates'];

          if (availableDates is List<dynamic>) {
            for (var dateData in availableDates) {
              if (dateData['date'] == selectedDate) {
                final availableTimeSlots = dateData['availableTimeSlots'];
                if (availableTimeSlots is List<dynamic>) {
                  for (var timeSlotData in availableTimeSlots) {
                    timeSlots.add(timeSlotData['time']);
                  }
                }
              }
            }
          }
        }

        if (timeSlots.isNotEmpty) {
          return timeSlots;
        }
      }

      throw Exception('Failed to fetch available time slots for date');
    } else {
      throw Exception('Failed to fetch available time slots for date');
    }
  }


}
