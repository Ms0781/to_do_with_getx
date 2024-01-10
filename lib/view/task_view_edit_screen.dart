import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_with_getx/controller/home_controller.dart';

class TaskEditViewScreen extends StatelessWidget{
  const TaskEditViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find(tag: "homeController");
    return WillPopScope(child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            homeController.titleController.clear();
            homeController.descriptionController.clear();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        actions: [
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.delete,color: Colors.white,)),
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.done,color: Colors.white,))

        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow.withOpacity(0.2)
            ),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            child: TextField(
              controller: homeController.titleController,
              decoration: const InputDecoration(
                  border: InputBorder.none
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Expanded(child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow.withOpacity(0.2)
            ),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            child: TextField(
              controller: homeController.descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                  border: InputBorder.none
              ),
            ),
          ))
        ],
      ),
    ), onWillPop: () async{
      homeController.titleController.clear();
      homeController.descriptionController.clear();
      return true;
    });
  }
}