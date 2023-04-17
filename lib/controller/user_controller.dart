import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/core/constants/http.dart';
import 'package:flutter_riverpod_blog_start/core/constants/move.dart';
import 'package:flutter_riverpod_blog_start/dto/auth_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/main.dart';
import 'package:flutter_riverpod_blog_start/model/auth/auth_repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';

final UserControllerProvider = Provider<UserController>((ref) {
  return UserController(ref);
});

class UserController {
  // Repository, ViewModel 의존
  final nContext = navigatorKey.currentContext;
  final Ref ref;

  UserController(this.ref);

  Future<void> join(String username, String password, String email) async {
    JoinReqDTO joinReqDTO = JoinReqDTO(
        username: username, password: password, email: email);
    ResponseDto responseDto = await ref.read(authRepositoryProvider).fatchJoin(
        joinReqDTO);
    if (responseDto.code == 1) {
      Navigator.pushNamed(nContext!, Move.loginPage);
    } else {
      ScaffoldMessenger.of(nContext!).showSnackBar(
          SnackBar(content: Text("회원가입 실패")));
    }
  }

  Future<void> login(String username, String password) async {
    LoginReqDTO loginReqDTO = LoginReqDTO(
        username: username, password: password);
    ResponseDto responseDTO = await ref.read(authRepositoryProvider).fetchLogin(
        loginReqDTO);
    if (responseDTO.code == 1) {
      // 1. 토큰을 휴대폰에 저장. 넣고 이동해야 하기 때문에 await
      await secureStorage.write(key: "jwt", value: responseDTO.token);

      // 2. 로그인 상태 등록
      ref.read(sessionProvider).loginSuccess(responseDTO.data,responseDTO.token!);

      // 3. 화면 이동
      Navigator.popAndPushNamed(nContext!, Move.postHomePage);
    } else {
      final snackBar = SnackBar(content: Text("로그인 실패"));
      ScaffoldMessenger.of(nContext!).showSnackBar(snackBar);
    }
  }
}