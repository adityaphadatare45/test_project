import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];
  bool isLoading = false;

  List<UserModel> get users => _users;

  Future<void> fetchUsers() async {
    isLoading = true;
    notifyListeners();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      _users = jsonData.map((e) => UserModel.fromJson(e)).toList();
    }
    isLoading = false;
    notifyListeners();
  }
}
