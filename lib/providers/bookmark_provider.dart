import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/post_model.dart';

class BookmarkProvider with ChangeNotifier {
  List<PostModel> _bookmarkedPosts = [];

  List<PostModel> get bookmarks => _bookmarkedPosts;

  BookmarkProvider() {
    loadBookmarks();
  }

  void addBookmark(PostModel post) {
    if (!_bookmarkedPosts.any((p) => p.id == post.id)) {
      _bookmarkedPosts.add(post);
      saveBookmarks();
      notifyListeners();
    }
  }

  void removeBookmark(int postId) {
    _bookmarkedPosts.removeWhere((p) => p.id == postId);
    saveBookmarks();
    notifyListeners();
  }

  bool isBookmarked(int postId) {
    return _bookmarkedPosts.any((p) => p.id == postId);
  }

  Future<void> saveBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data =
        _bookmarkedPosts.map((post) => jsonEncode(post.toJson())).toList();
    prefs.setStringList('bookmarks', data);
  }

  Future<void> loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList('bookmarks');
    if (data != null) {
      _bookmarkedPosts =
          data.map((e) => PostModel.fromJson(jsonDecode(e))).toList();
      notifyListeners();
    }
  }
}
