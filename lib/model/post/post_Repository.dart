import 'package:dio/dio.dart';
import 'package:flutter_riverpod_blog_start/core/constants/http.dart';
import 'package:flutter_riverpod_blog_start/dto/post_request.dart';
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
    try {
      Response response = await dio.get("/post",
          options: Options(headers: {"Authorization": "$jwt"}));
      ResponseDto responseDto = ResponseDto.fromJson(response.data);
      List<dynamic> mapList =
          responseDto.data; // data는 dynamic 타입 리스트다이나믹 타입으로 바꿔야한다.
      List<Post> postList =
          mapList.map((e) => Post.fromJson(e)).toList(); //e는 post처럼 생긴map
      responseDto.data = postList;
      return responseDto;
    } catch (e) {
      return ResponseDto(code: -1, msg: "실패 : ${e}");
    }
  }

  //통신
  Future<ResponseDto> fetchPost(int id, String jwt) async {
    try {
      Response response = await dio.get("/post/$id",
          options: Options(headers: {"Authorization": "$jwt"}));
      ResponseDto responseDto = ResponseDto.fromJson(response.data);
      responseDto.data = Post.fromJson(responseDto.data);
      return responseDto;
    } catch (e) {
      return ResponseDto(code: -1, msg: "실패 : ${e}");
    }
  }

  //삭제
  Future<ResponseDto> fetchDelete(int id, String jwt) async {
    try {
      Response response = await dio.delete("/post/$id",
          options: Options(headers: {"Authorization": "$jwt"}));
      ResponseDto responseDto = ResponseDto.fromJson(response.data);
      return responseDto;
    } catch (e) {
      return ResponseDto(code: -1, msg: "실패 : ${e}");
    }
  }

  // 수정
  Future<ResponseDto> fetchUpdate(
      int id, PostUpdateReqDTO postUpdateReqDTO, String jwt) async {
    try {
      Response response = await dio.put(
        "/post/$id",
        options: Options(headers: {"Authorization": "$jwt"}),
        data: postUpdateReqDTO.toJson(),
      );
      ResponseDto responseDto = ResponseDto.fromJson(response.data);
      responseDto.data = Post.fromJson(responseDto.data);
      return responseDto;
    } catch (e) {
      return ResponseDto(code: -1, msg: "실패 : ${e}");
    }
  }

  //글쓰기
  Future<ResponseDto> fetchSave(
      PostSaveReqDTO postSaveReqDTO, String jwt) async {
    try {
      Response response = await dio.post(
        "/post",
        options: Options(headers: {"Authorization": "$jwt"}),
        data: postSaveReqDTO.toJson(),
      );
      ResponseDto responseDto = ResponseDto.fromJson(response.data);
      responseDto.data = Post.fromJson(responseDto.data);
      return responseDto;
    } catch (e) {
      return ResponseDto(code: -1, msg: "실패 : ${e}");
    }
  }
}
