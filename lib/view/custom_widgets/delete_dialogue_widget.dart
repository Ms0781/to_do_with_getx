import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_with_getx/controller/home_controller.dart';

import '../home_screen.dart';

class DeleteDialogue extends StatelessWidget{
  const DeleteDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find(tag: "homeController");
    return AlertDialog(
      actions: [
        GestureDetector(
          onTap: (){
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.deepPurpleAccent
            ),
            child: Center(
              child: Text(
                "No",
                style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.yellow),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: (){
            homeController.deleteTask(homeController.viewTodo!.id!).then((value) {
              Get.back();
              Get.offAll(() => const HomeScreen());
            });
          },
          child: Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurpleAccent
            ),
            child: Center(
              child: Text(
                "Yes",
                style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.yellow),
              ),
            ),
          ),
        ),
      ],
      title: Text("Delete",style: GoogleFonts.roboto(fontSize: 20,color: Colors.deepPurpleAccent),),
      content: Text("Are sure you want to delete?",style: GoogleFonts.roboto(fontSize: 18,color: Colors.deepPurpleAccent),),
    );
  }

}