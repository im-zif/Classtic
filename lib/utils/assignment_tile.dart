import 'package:classtic/utils/pdf_button.dart';
import 'package:flutter/material.dart';

import '../pages/pdf_viewer.dart';

class AssignmentTile extends StatelessWidget {
  final String subject;
  final String description;
  final String? pdfUrl;
  final Function()? selectPDF;
  final Function()? uploadPDF;
  final Function()? remove;

  const AssignmentTile({
    super.key,
    required this.subject,
    required this.description,
    this.selectPDF,
    this.uploadPDF,
    this.remove,
    this.pdfUrl
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xFF2C333D),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subject,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: remove,
                    icon: const Icon(Icons.delete, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PdfButton(
                    buttonText: 'Select PDF',
                    onTap: selectPDF,
                  ),
                  PdfButton(
                    buttonText: 'Upload',
                    onTap: uploadPDF,
                  ),
                  PdfButton(
                    buttonText: 'View PDF',
                    onTap: (){
                      if (pdfUrl != null && pdfUrl!.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFViewerScreen(pdfUrl: pdfUrl!),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("No PDF uploaded yet")),
                        );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
