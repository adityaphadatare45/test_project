import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bookmark_provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarks = Provider.of<BookmarkProvider>(context).bookmarks;

    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarked Posts")),
      body: bookmarks.isEmpty
          ? const Center(child: Text("No bookmarks yet"))
          : ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (_, index) {
                final post = bookmarks[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Provider.of<BookmarkProvider>(context, listen: false)
                          .removeBookmark(post.id);
                    },
                  ),
                );
              },
            ),
    );
  }
}
