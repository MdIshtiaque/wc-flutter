import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dropdown_item.dart';

class DistrictApiService {
  Future<List<DropdownItem>> fetchDistricts() async {
    final response = await http.get(Uri.parse('http://13.234.85.182/api/districts'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['success']) {
        List jsonData = jsonResponse['data'];
        return jsonData.map((item) => DropdownItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load districts: ${jsonResponse['message']}');
      }
    } else {
      throw Exception('Failed to connect to the API');
    }
  }
}
