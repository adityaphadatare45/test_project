import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post_model.dart';

class PostProvider with ChangeNotifier {
  List<PostModel> _posts = [];
  bool isLoading = false;

  List<PostModel> get posts => _posts;

  Future<void> fetchPostsByUser(int userId) async {
    isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?userId=$userId'));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      _posts = jsonData.map((e) => PostModel.fromJson(e)).toList();
    }
    isLoading = false;
    notifyListeners();
  }
}
