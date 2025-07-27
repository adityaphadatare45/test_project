import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post_model.dart';

class PostProvider with ChangeNotifier {
  List<PostModel> _posts = [];
  bool isLoading = false;
  String? error;

  List<PostModel> get posts => _posts;

  Future<void> fetchPostsByUser(int userId) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/posts?userId=$userId'),
          headers: {
            'Accept': 'application/json',
            'User-Agent': 'MyFlutterApp/1.0', // <- required for many APIs
            },
          );

      if (response.statusCode == 200) {
        List jsonData = json.decode(response.body);
        _posts = jsonData.map((e) => PostModel.fromJson(e)).toList();
      } else {
        error = "Failed to load posts. Status: ${response.statusCode}";
      }
    } catch (e) {
      error = "Something went wrong: $e";
    }

    isLoading = false;
    notifyListeners();
  }
}
