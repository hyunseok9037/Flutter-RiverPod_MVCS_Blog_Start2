import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/detail_page/components/post_detail_buttons.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/detail_page/components/post_detail_content.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/detail_page/components/post_detail_page_view_model.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/detail_page/components/post_detail_title.dart';

class PostDetailBody extends ConsumerWidget {
  final postId;
  const PostDetailBody(this.postId,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostDetailPageModel? model = ref.watch(PostDetailPageProvider(postId));
    if(model == null){
      return const CircularProgressIndicator();
    }else{
      Post post = model.post;
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostDetailTitle(post.title),
            const Divider(),
            PostDetailButtons(post),
            Expanded(child: PostDetailContent(post.content),
            ),
          ],
        ),
      );
    }

  }
}
