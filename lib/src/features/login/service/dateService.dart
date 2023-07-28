import 'dart:convert';
import 'package:http/http.dart' as http;

class DateService {
  static Future<Set<int>> fetchAvailableDates() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/available_dates'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data is List<dynamic>) {
          // Assuming the API returns a list of integers representing available days
          return Set<int>.from(data.map((date) => date as int));
        }
      }
      return {}; // Return an empty set if the response is not successful or the data is not in the expected format.
    } catch (e) {
      // Handle any errors that occurred during the API call.
      // You may show an error message or handle it based on your app's requirements.
      print('Error fetching available dates: $e');
      return {}; // Return an empty set in case of error.
    }
  }
}
