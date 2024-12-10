import 'package:flutter/material.dart';
import 'package:resume_generated_app_cvbuilder/screens/frontpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CvBuilderApp());
}

class CvBuilderApp extends StatelessWidget {
  const CvBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FrontPageScreen(),
    );
  }
}
