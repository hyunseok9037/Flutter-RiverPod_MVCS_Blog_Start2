
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/controller/user_controller.dart';
import 'package:flutter_riverpod_blog_start/core/utils/validator_util.dart';
import 'package:flutter_riverpod_blog_start/model/auth/auth_repository.dart';
import 'package:flutter_riverpod_blog_start/view/components/custom_elevated_button.dart';
import 'package:flutter_riverpod_blog_start/view/components/custom_text_form_field.dart';

class LoginForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _username,
            hint: "Username",
            funValidator: validateUsername(),
          ),
          CustomTextFormField(
            controller: _password,
            hint: "Password",
            funValidator: validatePassword(),
          ),
          CustomElevatedButton(
            text: "로그인",
            funPageRoute: () async {
              if (_formKey.currentState!.validate()) {
            ref.read(UserControllerProvider).login(
                _username.text.trim(),
                _password.text.trim());
              }
            },
          ),
          TextButton(
            onPressed: () {

            },
            child: const Text("아직 회원가입이 안되어 있나요?"),
          ),
          TextButton(
            onPressed: () {

            },
            child: const Text("홈페이지 로그인 없이 가보는 테스트"),
          ),
        ],
      ),

    );
  }
}
