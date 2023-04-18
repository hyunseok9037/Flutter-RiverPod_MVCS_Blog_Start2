

import 'package:flutter_riverpod_blog_start/dto/user_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/auth/user_Repository.dart';

void main() async {
  await fetchJoin_test();
  await fetchLogin_test();
}

Future<void> fetchJoin_test() async{
  JoinReqDTO joinReqDTO = JoinReqDTO(username: "meta2", password: "1234", email: "meta@nate.com");
  ResponseDto responseDTO = await UserRepository().fetchJoin(joinReqDTO);
  print(responseDTO.code);
  print(responseDTO.msg);
}

Future<void> fetchLogin_test() async {
  LoginReqDTO loinReqDTO = LoginReqDTO(
      username: "ssar", password: "1234");
  ResponseDto responseDTO = await UserRepository().fetchLogin(loinReqDTO);
  print(responseDTO.code);
  print(responseDTO.msg);
  print(responseDTO.token);
}