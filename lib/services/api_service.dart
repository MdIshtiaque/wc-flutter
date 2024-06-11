import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class ApiService {
  Future<User> login(String email, String password) async {
    var url = Uri.parse('http://13.234.85.182/api/login');
    var response = await http.post(url, body: {
      'email' : email,
      'password' : password,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['success']) {
        return User.fromJson(json['data']['user']..['token'] = json['data']['token']);
      } else {
        throw Exception("Failed to login: ${json['message']}");
      }
    } else if (response.statusCode == 401) {
      throw Exception('Incorrect Credentials');
    } else {
      throw Exception('Failed to connect Api');
    }
  }
}