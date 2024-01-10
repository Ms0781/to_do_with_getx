import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_with_getx/controller/home_controller.dart';
import 'package:to_do_with_getx/view/custom_widgets/to_do_widget.dart';
import 'package:to_do_with_getx/view/task_view_edit_screen.dart';

import '../model/to_do_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController =
        Get.put(HomeController(), tag: "homeController");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        title: const Text('To Do'),
        titleTextStyle: GoogleFonts.roboto(
            textStyle: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => homeController.isLoading.value
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurpleAccent,
                    ),
                  ))
              : homeController.listOfToDo.isEmpty
                  ? Center(
                      child: Text(
                        "No Data",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    )
                  : ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: GridView.builder(
                          itemCount: homeController.listOfToDo.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (BuildContext context, int index) {
                            Todo todo = homeController.listOfToDo[index];
                             return GestureDetector(
                              onTap: () {
                                homeController.titleController.text = todo.title;
                                homeController.descriptionController.text = todo.description;
                                homeController.setViewTodoValue(todo);
                                Get.to(() => const TaskEditViewScreen());
                              },
                              child: ToDoWidget(
                                  title: todo.title,
                                  description: todo.description),
                            );
                          })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        onPressed: () {
          Get.bottomSheet(Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            padding: const EdgeInsets.all(10),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add Task",
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.w400),
                        ),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.deepPurpleAccent,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Title",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.deepPurpleAccent),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurpleAccent.withOpacity(0.05)),
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: homeController.titleController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        cursorColor: Colors.deepPurpleAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.deepPurpleAccent),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurpleAccent.withOpacity(0.05)),
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: homeController.descriptionController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        minLines: 5,
                        maxLines: 10,
                        cursorColor: Colors.deepPurpleAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if(homeController.titleController.text.isEmpty || homeController.descriptionController.text.isEmpty){
                            Fluttertoast.showToast(msg: "Title or Description is empty");
                        }else{
                          homeController.addTodo();
                          homeController.getToDoList();
                          Get.back();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.deepPurpleAccent),
                        child: Center(
                          child: Text(
                            "Add Task",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
