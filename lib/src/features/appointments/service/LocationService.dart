import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  static Future<List<String>> fetchLocations() async {
    final response = await http.get(Uri.parse('http://localhost:8080/hemobancos'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List<dynamic>) {
        return List<String>.from(data.map((location) => location.toString()));
      }
    }
    return []; // Return an empty list if the response is not successful or the data is not in the expected format.
  }
}
