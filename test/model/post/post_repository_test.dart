

import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/model/post/post_repository.dart';

void main() async {
  await fetchPostList_test();
}

Future<void> fetchPostList_test() async{
  String jwt = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjb3PthqDtgbAiLCJpZCI6MSwiZXhwIjoxNjgyNjQ4NDYyfQ.0TUPUwhFa6cv5A9Wlzwz3Wz77uh8vuuSdePujQyZKiVW0UOe9Ih8JMhCcJQe2mzqTtjz_C8wnTHSme_tqQFeHg";
  ResponseDto responseDTO = await PostRepository().fetchPostList(jwt);
  print(responseDTO.code);
  print(responseDTO.msg);
  List<Post> postList = responseDTO.data;
  postList.forEach((element) {
    print(element.title);
  });
}