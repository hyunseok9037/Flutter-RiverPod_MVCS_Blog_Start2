import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/model/post/post_Repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';


final PostDetailPageProvider = StateNotifierProvider.family.autoDispose<PostDetailPageViewModel, PostDetailPageModel?, int>((ref, postId) {
  SessionUser sessionUser = ref.read(sessionProvider);
  return PostDetailPageViewModel(null,ref)..notifyInit(postId,sessionUser.jwt!); //.. init state가 초기화 된다
});


// 창고 데이터 model 일관성유지 하기 위해 따로 만듬
class  PostDetailPageModel{
    Post post;
    PostDetailPageModel({required this.post});
}

// 창고 store 창고에 버튼이 4개있다
class PostDetailPageViewModel extends StateNotifier<PostDetailPageModel?> {
  Ref ref;
  PostDetailPageViewModel(super._state, this.ref);

  // 창고초기화 데이터만 변경하면 재빌드 컨벤션view에게 알려주는 함수다 통신
  void notifyInit(int id, String jwt) async {
   ResponseDto responseDto = await PostRepository().fetchPost(id, jwt);
    state = PostDetailPageModel(post: responseDto.data);
  }

  // 삭제
  void notifyRemove(int id){
   Post post = state!.post;
   if(post.id == id){
     state = null;
   }
  }

  // api 수정 요청 -> 수정된 post를 돌려받음.
  void notifyUpdate(Post updatePost){
    state = PostDetailPageModel(post: updatePost);
  }

}