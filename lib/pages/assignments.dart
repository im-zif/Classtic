import 'package:flutter/material.dart';
import 'package:classtic/utils/assignment_tile.dart';

class Assignments extends StatefulWidget {
  const Assignments({super.key});

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {

  //select pdf method
  void selectPDF(){

  }

  //upload pdf method
  void uploadPDF(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF0D0F13),
        body: Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: Column(
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Assignments',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.add),
              )
            ],
            ),
            AssignmentTile(
              subject: 'subject',
              description: 'description',
              selectPDF: selectPDF,
              uploadPDF: uploadPDF,
            )
          ]
        )
      )
    );
  }
}
