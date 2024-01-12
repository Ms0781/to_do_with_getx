import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:to_do_with_getx/data/database.dart';
import 'package:to_do_with_getx/view/home_screen.dart';

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
        lastUpdateTime: "${DateTime.now()}", deletedStatus: 0));
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

  Future<void> deleteTask(int id) async{
      DbHelper.instance.deleteTask(id).then((value) {
        getToDoList();
      });
  }

  void updateTask(Todo todo) async{
    DbHelper.instance.updateTask(todo).then((value) {
      getToDoList();
      Get.offAll(const HomeScreen());
    });
  }

}