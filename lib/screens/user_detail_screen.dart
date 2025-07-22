import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/post_provider.dart';
import '../providers/bookmark_provider.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;
  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    postProvider.fetchPostsByUser(user.id);

    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Consumer<PostProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: provider.posts.length,
            itemBuilder: (_, index) {
              final post = provider.posts[index];
              return Consumer<BookmarkProvider>(
                builder: (context, bookmarkProvider, _) {
                  final isBookmarked = bookmarkProvider.isBookmarked(post.id);
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                    trailing: IconButton(
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                      ),
                      onPressed: () {
                        isBookmarked
                            ? bookmarkProvider.removeBookmark(post.id)
                            : bookmarkProvider.addBookmark(post);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
