import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../login/HemobancoAddress.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

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

  static Future<HemobancoAddress> fetchLocationByName(int locationName) async {
    final response = await http.get(Uri.parse('http://localhost:8080/hemobanco_dates/hemobanco/$locationName'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData is List) {
        // Handle the case where jsonData is a list
        if (jsonData.isNotEmpty) {
          final firstItem = jsonData[0];
          return HemobancoAddress.fromJson(firstItem);
        } else {
          throw Exception('List is empty');
        }
      } else if (jsonData is Map<String, dynamic>) {
        // Handle the case where jsonData is a map
        return HemobancoAddress.fromJson(jsonData);
      } else {
        throw Exception('Unexpected data structure');
      }
    } else {
      throw Exception('Failed to fetch location');
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
