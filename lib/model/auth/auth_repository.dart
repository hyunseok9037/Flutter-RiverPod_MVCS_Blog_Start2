import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/core/constants/http.dart';
import 'package:flutter_riverpod_blog_start/dto/auth_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/user/user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class AuthRepository {

  Future<ResponseDto> fatchJoin(JoinReqDTO joinReqDTO) async {
    Response response = await dio.post("/join", data: joinReqDTO.toJson());
    ResponseDto responseDto = ResponseDto.fromJson(response.data);
    responseDto.data = User.fromJson(responseDto.data);
    return responseDto;
  }

  Future<ResponseDto> fetchLogin(LoginReqDTO loginReqDTO) async{
    // 1. 통신 시작
    Response response = await dio.post("/login",data: loginReqDTO.toJson());

    // 2. DTO 파싱
    ResponseDto responseDTO = ResponseDto.fromJson(response.data);
    responseDTO.data = User.fromJson(responseDTO.data);

    // 3. 토큰 받기
    responseDTO.token = response.headers["authorization"].toString();
    return responseDTO;
  }

  }
