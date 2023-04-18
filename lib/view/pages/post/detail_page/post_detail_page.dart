import 'package:flutter/material.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/detail_page/components/post_detail_body.dart';

class PostDetailPage extends StatelessWidget {
  final int postId;
  const PostDetailPage(this.postId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PostDetailBody(postId),
    );
  }

}
