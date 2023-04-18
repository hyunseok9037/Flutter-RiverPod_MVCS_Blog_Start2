import 'package:flutter/material.dart';

class PostDetailContent extends StatelessWidget {
  final String content;
  const PostDetailContent(this.content,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( //얘만 길어질수 있어서 이거씀
      child: Text("$content"),
    );
  }
}
