import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/controller/post_controller.dart';
import 'package:flutter_riverpod_blog_start/core/utils/validator_util.dart';
import 'package:flutter_riverpod_blog_start/view/components/custom_elevated_button.dart';
import 'package:flutter_riverpod_blog_start/view/components/custom_text_form_field.dart';
import 'package:flutter_riverpod_blog_start/view/components/custom_textarea.dart';

class PostUpdateForm extends ConsumerWidget {
  final post;
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();

  PostUpdateForm(this.post,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // TextFormFiled의 값을 초기화 하는 방법
    _title.text = post.title;
    _content.text = post.content;

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          CustomTextFormField(
            controller: _title,
            hint: "Title",
            funValidator: validateTitle(),
          ),
          CustomTextArea(
            controller: _content,
            hint: "Content",
            funValidator: validateContent(),
          ),
          // homepage -> detailpage -> detailpage
          CustomElevatedButton(
            text: "글 수정하기",
            funPageRoute: () async {
              if (_formKey.currentState!.validate()) {
                ref.read(postControllerProvider).updatePost(post.id, _title.text, _content.text);
              }
            },
          ),
        ],
      ),
    );
  }
}
