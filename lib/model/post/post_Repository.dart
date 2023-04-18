import 'package:dio/dio.dart';
import 'package:flutter_riverpod_blog_start/core/constants/http.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';


class PostRepository {
  static final PostRepository _instance = PostRepository._single();
  factory PostRepository() {
    return _instance;
  }

  PostRepository._single();

  // 메서드의 목적: 통신 + 파싱
  Future<ResponseDto> fetchPostList(String jwt) async {
    try{
      Response response = await dio.get("/post", options: Options(
          headers: {
            "Authorization": "$jwt"
          }
      ));
      ResponseDto responseDto = ResponseDto.fromJson(response.data);
      List<dynamic> mapList = responseDto.data; // data는 dynamic 타입 리스트다이나믹 타입으로 바꿔야한다.
      List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList(); //e는 post처럼 생긴map
      responseDto.data = postList;
      return responseDto;
    }catch(e){
      return ResponseDto(code: -1,msg: "실패 : ${e}");
    }

  }
}