import 'package:intl/intl.dart';

class JoinReqDTO {
  final String username;
  final String password;
  final String email;

  JoinReqDTO({
    required this.username,
    required this.password,
    required this.email,
  });

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트
  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "email": email,
  };

}

class LoginReqDTO {
  final String username;
  final String password;

  LoginReqDTO({
    required this.username,
    required this.password,
  });

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트
  Map<String, dynamic> toJson() =>
      {
        "username": username,
        "password": password,
      };

}