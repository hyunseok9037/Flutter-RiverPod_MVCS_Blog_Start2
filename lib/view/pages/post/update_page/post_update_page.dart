import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/update_page/components/post_update_body.dart';
import 'package:logger/logger.dart';

class PostUpdatePage extends StatelessWidget {
  final post;
  PostUpdatePage(this.post,{super.key});

  @override
  Widget build(BuildContext context) {
    Logger().d("UpdatePage");
    return Scaffold(
      appBar: AppBar(),
      body: PostUpdateBody(post),
    );
  }
}
