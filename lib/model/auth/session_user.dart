import 'package:flutter_riverpod_blog_start/model/user/user.dart';


// 최초 앱이 실행될 때 초기화 되어야 함.
// 1. JWT 존재 유무 확인 (I/O)
// 2. JWT로 회원정보 받아봄 (I/O)
// 3. OK -> loginSuccess 호출
// 4. FAIL ->loginpage로 이동
class SeesionUser{
  User? user;
  String? jwt;  //jwt토큰을 들고있고
  bool? isLogin; //true면 로그인

 
  void loginSuccess(User user, String jwt){
    this.user = user;
    this.jwt = jwt;
    this.isLogin = true;
  }

  
  void logoutSuccess(){
    this.user = null;
    this.jwt = null;
    this.isLogin = false;
  }

}