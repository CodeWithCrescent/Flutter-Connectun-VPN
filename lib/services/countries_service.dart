import 'dart:convert';
import 'package:flutter/services.dart';

class CountryService {
  Future<Map<String, Map<String, String>>> getCountryDetails() async {
    final String response =
        await rootBundle.loadString('assets/data/countries.json');
    final data = json.decode(response);

    Map<String, Map<String, String>> countryDetails = {};

    // Iterate through the 'Results' map and populate countryDetails
    (data['Results'] as Map<String, dynamic>).forEach((shortName, countryData) {
      countryDetails[shortName] = {
        'Name': countryData['Name'],
        'Type': countryData['type']
      };
    });

    // Simulate a delay if needed
    await Future.delayed(const Duration(seconds: 2));

    return countryDetails;
  }
}

