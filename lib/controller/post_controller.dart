import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/dto/post_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/main.dart';
import 'package:flutter_riverpod_blog_start/model/post/post_Repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/detail_page/components/post_detail_page_view_model.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/home_page/post_home_page_view_model.dart';


final postControllerProvider = Provider<postController>((ref) {
  return postController(ref);
});

class postController {
  // Repository, ViewModel 의존
  final mContext = navigatorKey.currentContext;
  final Ref ref;
  postController(this.ref);

  Future<void> refresh() async { //새로 고침?
    SessionUser sessionUser = ref.read(sessionProvider);
    ref.read(postHomePageProvider.notifier).notifyInit(sessionUser.jwt!);
  }

  Future<void> deletePost(int id) async {
    SessionUser sessionUser = ref.read(sessionProvider);
   await PostRepository().fetchDelete(id, sessionUser.jwt!);
   ref.read(postHomePageProvider.notifier).notifyRemove(id); //연결은 컨트롤러 삭제하고 뒤로 가면 재빌드되네?
   Navigator.pop(mContext!);
  }

  Future<void> updatePost(int id, String title, String content) async {
    PostUpdateReqDTO postUpdateReqDTO = PostUpdateReqDTO(title: title, content: content);
    SessionUser sessionUser = ref.read(sessionProvider);

   ResponseDto responseDto = await PostRepository().fetchUpdate(id,postUpdateReqDTO, sessionUser.jwt!);
    ref.read(PostDetailPageProvider(id).notifier).notifyUpdate(responseDto.data);
    ref.read(postHomePageProvider.notifier).notifyUpdate(responseDto.data);
    Navigator.pop(mContext!);
  }

  Future<void> savePost(String title, String content) async {
    PostSaveReqDTO postSaveReqDTO = PostSaveReqDTO(title: title, content: content);
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDto responseDto = await PostRepository().fetchSave(postSaveReqDTO, sessionUser.jwt!);
    ref.read(postHomePageProvider.notifier).notifyAdd(responseDto.data);
    Navigator.pop(mContext!);
  }

}