import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:to_do_with_getx/data/database.dart';

import '../model/to_do_model.dart';

class HomeController extends GetxController{
  final listOfToDo = <Todo>[].obs;
  RxBool isLoading = false.obs;
  Todo? viewTodo;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() async{
    super.onInit();
    getToDoList();
  }

  setTodoList(List<Todo> listOfToDoItems) {
    listOfToDo.value = listOfToDoItems;
    notifyChildrens();
  }

  addTodo() async{
    await DbHelper.instance.insertTask(Todo(
        title: titleController.text,
        description: descriptionController.text,
        timeOfCreation: "${DateTime.now()}",
        lastUpdateTime: "${DateTime.now()}"));
  }

  getToDoList() async{
    isLoading.value = true;
    setTodoList(await DbHelper.instance.getAllTodoList());
    isLoading.value = false;
  }

  setViewTodoValue(Todo todo){
    viewTodo = todo;
    notifyChildrens();
  }
}