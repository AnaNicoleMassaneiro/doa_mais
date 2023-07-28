import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../login/HemobancoAddress.dart';

class LocationService {
  static Future<List<HemobancoAddress>> fetchLocations() async {
    final response = await http.get(Uri.parse('http://localhost:8080/hemobancos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data is List<dynamic>) {
        return data.map((location) => HemobancoAddress.fromJson(location)).toList();
      }
    }
    return [];
  }
}