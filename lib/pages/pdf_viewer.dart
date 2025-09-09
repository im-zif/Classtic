import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfUrl; // full path, not the public URL

  const PDFViewerScreen({super.key, required this.pdfUrl});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? localFilePath;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _downloadPDF();
  }

  Future<void> _downloadPDF() async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(widget.pdfUrl);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${ref.name}');
      await ref.writeToFile(file);
      setState(() {
        localFilePath = file.path;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(title: const Text("PDF Viewer")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("PDF Viewer")),
        body: Center(child: Text('Error: $error')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("PDF Viewer")),
      body: PDF().fromPath(localFilePath!),
    );
  }
}
