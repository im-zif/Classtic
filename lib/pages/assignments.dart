import 'package:flutter/material.dart';

class Assignments extends StatefulWidget {
  const Assignments({super.key});

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Assignments',
        style: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }
}
