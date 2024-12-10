import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class CreateResumePage extends StatefulWidget {
  final Function(String, String) onSave;

  const CreateResumePage({super.key, required this.onSave});

  @override
  State<CreateResumePage> createState() => _CreateResumePageState();
}

class _CreateResumePageState extends State<CreateResumePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    experienceController.dispose();
    super.dispose();
  }

  Future<void> generatePdf(String name, String experience) async {
    try {
      final pdf = pw.Document();
      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Resume of $name',
                  style: const pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Text('Experience:', style: const pw.TextStyle(fontSize: 18)),
              pw.Text(experience),
            ],
          );
        },
      ));

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/resume.pdf');
      await file.writeAsBytes(await pdf.save());

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerScreen(filePath: file.path),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Resume')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Resume Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Name:'),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Experience:'),
            TextField(
              controller: experienceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your experience',
              ),
              maxLines: 4, // Allow multiline input
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String experience = experienceController.text;
                if (name.isEmpty || experience.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill out all fields')),
                  );
                  return;
                }

                widget.onSave(name, experience);
                generatePdf(name, experience);
                Navigator.pop(context); // Return to the previous screen
              },
              child: const Text('Generate Resume'),
            ),
          ],
        ),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String filePath;

  const PdfViewerScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Resume')),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
