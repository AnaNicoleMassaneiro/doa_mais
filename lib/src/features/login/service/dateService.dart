import 'dart:convert';
import 'package:http/http.dart' as http;

class DateService {
  static Future<List<DateTime>> fetchAvailableDatesForLocation(int hemobancoId) async {
    final response = await http.get(Uri.parse('http://localhost:8080/hemobanco_dates/$hemobancoId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Check if jsonData is a map and contains the 'availableDates' key
      if (jsonData is Map<String, dynamic> && jsonData.containsKey('availableDates')) {
        var datesList = jsonData['availableDates'];

        // If datesList is a list, process the dates
        if (datesList is List) {
          List<DateTime> dates = [];
          for (var dateData in datesList) {
            // Assuming that the dates are stored as strings in the format 'YYYY-MM-DD'
            DateTime date = DateTime.parse(dateData['date']);
            dates.add(date);
          }
          return dates;
        }
      }

      throw Exception('Failed to fetch available dates for location');
    } else {
      throw Exception('Failed to fetch available dates for location');
    }
  }

  static Future<List<String>> fetchAvailableTimeSlotsForDate(int hemobancoId, String selectedDate) async {
    final response = await http.get(Uri.parse('http://localhost:8080/hemobanco_dates/$hemobancoId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Check if jsonData is a map and contains the 'availableDates' key
      if (jsonData is Map<String, dynamic> && jsonData.containsKey('availableDates')) {
        var datesList = jsonData['availableDates'];

        // If datesList is a list, find the selected date and extract its time slots
        if (datesList is List) {
          for (var dateData in datesList) {
            if (dateData['date'] == selectedDate) {
              List<String> timeSlots = [];
              for (var timeSlotData in dateData['availableTimeSlots']) {
                timeSlots.add(timeSlotData['time']);
              }
              return timeSlots;
            }
          }
        }
      }

      throw Exception('Failed to fetch available time slots for date');
    } else {
      throw Exception('Failed to fetch available time slots for date');
    }
  }
}
