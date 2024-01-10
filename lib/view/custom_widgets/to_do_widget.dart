import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoWidget extends StatelessWidget {
  final String title;
  final String description;
  const ToDoWidget({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurpleAccent,width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.yellow.withOpacity(0.2)
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.length > 8 ? "${title.substring(0,9)}\t..." : title,style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
          const SizedBox(height: 10,),
          const Divider(height: 1,color: Colors.black26,),
          const SizedBox(height: 10,),
          Expanded(child: Text(description.length > 50 ? description.substring(0,50) : description,style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.w400),))
        ],
      ),
    );
  }
}
