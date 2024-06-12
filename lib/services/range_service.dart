import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dropdown_item.dart';

class RangeApiService {
  Future<List<DropdownItem>> fetchRanges(int divisionId) async {
    final response = await http.get(Uri.parse('http://13.234.85.182/api/rangesByDivision/$divisionId'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['success']) {
        List jsonData = jsonResponse['data'];
        return jsonData.map((item) => DropdownItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load ranges: ${jsonResponse['message']}');
      }
    } else {
      throw Exception('Failed to connect to the API');
    }
  }
}
