class Todo{
  int? id;
  String title;
  String description;
  String timeOfCreation;
  String lastUpdateTime;

  Todo({this.id, required this.title, required this.description, required this.timeOfCreation,
    required this.lastUpdateTime});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    timeOfCreation: json["createDate"],
    lastUpdateTime: json["updateDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "createDate": timeOfCreation,
    "updateDate": lastUpdateTime,
  };

}