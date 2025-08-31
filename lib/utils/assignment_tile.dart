import 'package:classtic/utils/pdf_button.dart';
import 'package:flutter/material.dart';

class AssignmentTile extends StatelessWidget {

  final String subject;
  final String description;
  final Function()? selectPDF;
  final Function()? uploadPDF;

  const AssignmentTile({super.key, required this.subject, required this.description, required this.selectPDF, required this.uploadPDF});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color(0xFF2C333D),
            border: BoxBorder.all(
                color: Color(0xFF2C333D)
            ),
            borderRadius: BorderRadius.circular(6)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Column(
            children: [
              Text(
                'Subject',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Description',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PdfButton(
                    buttonText: 'Select PDF',
                    onTap: selectPDF,
                  ),
                  SizedBox(width: 20,),
                  PdfButton(
                    buttonText: 'Upload',
                    onTap: uploadPDF,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
