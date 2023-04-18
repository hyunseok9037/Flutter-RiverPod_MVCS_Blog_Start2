
import 'package:dio/dio.dart';
import 'package:flutter_riverpod_blog_start/core/constants/http.dart';
import 'package:flutter_riverpod_blog_start/dto/auth_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/user/user.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';
import 'package:logger/logger.dart';


class UserRepository {
  static final UserRepository _instance = UserRepository._single();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._single();

  Future<SessionUser> fetchJwtVerify() async {
    SessionUser sessionUser = SessionUser();
    String? deviceJwt = await secureStorage.read(key: "jwt");
    if (deviceJwt != null) {
      try {
        Response response = await dio.get("/jwtToken", options: Options(
            headers: {
              "Authorization": "$deviceJwt"
            }
        ));
        ResponseDto responseDTO = ResponseDto.fromJson(response.data);
        responseDTO.token = deviceJwt;
        responseDTO.data = User.fromJson(responseDTO.data);

        if (responseDTO.code == 1) {
          sessionUser.loginSuccess(responseDTO.data, responseDTO.token!);
        } else {
          sessionUser.logoutSuccess();
        }
        return sessionUser;
      } catch (e) {
        Logger().d("에러 이유 : " + e.toString());
        sessionUser.logoutSuccess();
        return sessionUser;
      }
    } else {
      sessionUser.logoutSuccess();
      return sessionUser;
    }
  }

  Future<ResponseDto> fetchJoin(JoinReqDTO joinReqDTO) async {
    try {
      Response response = await dio.post("/join", data: joinReqDTO.toJson());
      ResponseDto responseDTO = ResponseDto.fromJson(response.data);
      responseDTO.data = User.fromJson(responseDTO.data);
      return responseDTO;
    } catch (e) {
      //만약 서버에서 이걸 안주면 이렇게 임의로 만들어야 함.
      return ResponseDto(code: -1, msg: "유저네임 중복");
    }
  }

  Future<ResponseDto> fetchLogin(LoginReqDTO loginReqDTO) async {
    try {
      // 1. 통신 시작
      Response response = await dio.post("/login", data: loginReqDTO.toJson());

      // 2. DTO 파싱
      ResponseDto responseDTO = ResponseDto.fromJson(response.data);
      responseDTO.data = User.fromJson(responseDTO.data);

      // 3. 토큰 받기
      final authorization = response.headers["authorization"];
      if (authorization != null) {
        responseDTO.token = authorization.first;
      }
      return responseDTO;
    } catch (e) {
      return ResponseDto(code: -1, msg: "유저네임 혹은 비번이 틀렸습니다");
    }
  }
}