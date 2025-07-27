import 'package:flutter/foundation.dart'; // for compute
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];
  bool isLoading = false;

  List<UserModel> get users => _users;

  // Background JSON parsing function
  static List<UserModel> _parseUsers(String responseBody) {
    final List decoded = json.decode(responseBody);
    return decoded.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<void> fetchUsers() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
         headers: {
           'Accept': 'application/json',
           'User-Agent': 'MyFlutterApp/1.0', // <- required for many APIs
        },
      );

      if (response.statusCode == 200) {
        // ✅ Parse JSON in background isolate
         print("Data fetched successfully!");
        _users = await compute(_parseUsers, response.body);
      }else{
        print("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
