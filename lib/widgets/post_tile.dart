import 'package:flutter/material.dart';
import 'package:test_project/models/post_model.dart';

class PostTile extends StatelessWidget {
  final PostModel post;
  final bool isBookmarked;
  final VoidCallback onBookmarkToggle;

  const PostTile({
    super.key,
    required this.post,
    required this.isBookmarked,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        title: Text(
          post.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          post.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: isBookmarked ? Colors.blueAccent : Colors.grey,
          ),
          onPressed: onBookmarkToggle,
        ),
      ),
    );
  }
}
