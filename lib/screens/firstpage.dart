import 'package:flutter/material.dart';
import 'package:resume_generated_app_cvbuilder/screens/create_resume.dart';
import 'package:flutter/material.dart';
import 'package:resume_generated_app_cvbuilder/screens/create_resume.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  List<Map<String, String>> resumes = []; // Declare resumes list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the CreateResumePage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateResumePage(onSave: (name, experience) {
                setState(() {
                  resumes.add({'name': name, 'experience': experience});
                });
              }),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: resumes.isEmpty
          ? const Center(
              child: Text(
                'No resumes created yet. Tap the "+" button to create one!',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: resumes.length,
              itemBuilder: (context, index) {
                var resume = resumes[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(resume['name'] ?? 'No Name',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(resume['experience'] ?? 'No Experience'),
                  ),
                );
              },
            ),
    );
  }
}
