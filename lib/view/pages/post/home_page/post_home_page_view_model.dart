import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/model/post/post_Repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';


//view model
//창고 관리자 provider 는 창고를 관리한다
final postHomePageProvider = StateNotifierProvider<PostHomePageViewModel, PostHomePageModel?>((ref) {
  SessionUser sessionUser = ref.read(sessionProvider);
  return PostHomePageViewModel(null)..init(sessionUser.jwt!); //.. init state가 초기화 된다
});


// 창고 데이터 model 일관성유지 하기 위해 따로 만듬
class PostHomePageModel{
    List<Post> posts;
    PostHomePageModel({required this.posts});
}

// 창고 store 창고에 버튼이 4개있다
class PostHomePageViewModel extends StateNotifier<PostHomePageModel?> {
  PostHomePageViewModel(super._state);

  // 창고초기화 데이터만 변경하면 재빌드
  void init(String jwt) async {
   ResponseDto responseDto = await PostRepository().fetchPostList(jwt);
    state = PostHomePageModel(posts: responseDto.data);
  }

  // 추가 창고데이터에 추가한다
  void add(Post post){
      List<Post> posts = state!.posts; //기존 List
      List<Post> newPosts = [...posts, post];
      state = PostHomePageModel(posts: newPosts); //+ 1건
    }

  // 삭제
  void remove(int id){
    List<Post> posts = state!.posts;
    List<Post> newPosts = posts.where((e) => e.id != id).toList();
    state = PostHomePageModel(posts: newPosts);
  }

  // 수정
  void update(Post post){
    List<Post> posts = state!.posts;
    List<Post> newPosts = posts.map((e) => e.id == post.id ? post :e).toList();
    state = PostHomePageModel(posts: newPosts);
  }

}