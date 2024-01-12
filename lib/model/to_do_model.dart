import 'package:to_do_with_getx/data/db_fields.dart';

class Todo{
  int? id;
  String title;
  String description;
  String timeOfCreation;
  String lastUpdateTime;
  int deletedStatus;

  Todo({this.id, required this.title, required this.description, required this.timeOfCreation,
    required this.lastUpdateTime,required this.deletedStatus});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json[DBFields.columnId],
    title: json[DBFields.columnTitle],
    description: json[DBFields.columnDescription],
    timeOfCreation: json[DBFields.columnCreateDate],
    lastUpdateTime: json[DBFields.columnUpdateDate],
    deletedStatus: json[DBFields.columnDeleteStatus]
  );

  Map<String, dynamic> toJson() => {
    DBFields.columnId : id,
    DBFields.columnTitle : title,
    DBFields.columnDescription : description,
    DBFields.columnCreateDate : timeOfCreation,
    DBFields.columnUpdateDate: lastUpdateTime,
    DBFields.columnDeleteStatus : deletedStatus
  };

}