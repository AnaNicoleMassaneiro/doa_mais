import 'dart:convert';
import 'package:http/http.dart' as http;

class DateService {
  static Future<List<DateTime>> fetchAvailableDates() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/hemobanco_dates'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data is List<dynamic>) {
          List<DateTime> dates = [];
          for (var item in data) {
            if (item['availableDates'] is List<dynamic>) {
              List<dynamic> availableDates = item['availableDates'];
              for (var date in availableDates) {
                if (date['date'] is String) {
                  DateTime parsedDate = DateTime.parse(date['date']);
                  dates.add(parsedDate);
                }
              }
            }
          }
          return dates;
        }
      }
      return [];
    } catch (e) {
      print('Error fetching available dates: $e');
      return [];
    }
  }
}
