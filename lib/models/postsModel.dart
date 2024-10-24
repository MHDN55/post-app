class Posts {
  final int id;
  final String title;
  final String body;
  Posts({
    required this.id,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Posts.fromJson(Map<String, dynamic> parsedJson) {
    return Posts(
      id: parsedJson["id"],
      body: parsedJson["body"],
      title: parsedJson["title"],
    );
  }
}
