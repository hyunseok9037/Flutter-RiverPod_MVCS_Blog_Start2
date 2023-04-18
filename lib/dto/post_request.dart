class PostUpdateReqDTO {
  final String title;
  final String content;

  PostUpdateReqDTO({
    required this.title,
    required this.content,
  });

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트
  Map<String, dynamic> toJson() =>
      {
        "title": title,
        "content": content,
      };
}

class PostSaveReqDTO {
  final String title;
  final String content;

  PostSaveReqDTO({
    required this.title,
    required this.content,
  });

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트
  Map<String, dynamic> toJson() =>
      {
        "title": title,
        "content": content,
      };
}