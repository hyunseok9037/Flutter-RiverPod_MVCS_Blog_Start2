import 'package:flutter/material.dart';
import 'package:flutter_riverpod_blog_start/view/pages/user/detail_page/components/user_detail_body.dart';
import 'package:logger/logger.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Logger().d("UserInfoPage");
    return Scaffold(
      appBar: AppBar(),
      body: UserDetailBody(),
    );
  }

}
