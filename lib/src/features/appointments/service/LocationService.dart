import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../login/HemobancoAddress.dart';

class LocationService {
  static Future<List<HemobancoAddress>> fetchLocations() async {
    final response = await http.get(Uri.parse('http://localhost:8080/hemobancos'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      List<HemobancoAddress> locations = jsonData.map((data) => HemobancoAddress.fromJson(data)).toList();
      return locations;
    } else {
      throw Exception('Failed to fetch locations');
    }
  }

  static Future<List<DateTime>> fetchAvailableDatesForLocation(String locationId) async {
    final response = await http.get(Uri.parse('http://localhost:8080/hemobanco_dates/$locationId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      List<DateTime> availableDates = jsonData.map((dateString) => DateTime.parse(dateString)).toList();
      return availableDates;
    } else {
      throw Exception('Failed to fetch available dates');
    }
  }
}
