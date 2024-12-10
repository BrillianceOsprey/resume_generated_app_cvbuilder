import 'package:flutter/material.dart';
import 'package:resume_generated_app_cvbuilder/screens/firstpage.dart';

class FrontPageScreen extends StatefulWidget {
  const FrontPageScreen({super.key});

  @override
  State<FrontPageScreen> createState() => _FrontPageScreenState();
}

class _FrontPageScreenState extends State<FrontPageScreen> {
  double _progressValue = 0.0; // Initial progress value

  void _startProgressAndNavigate() {
    // Reset progress value
    setState(() {
      _progressValue = 0.0;
    });

    // Simulate progress animation
    Future.doWhile(() async {
      if (_progressValue >= 1.0) {
        // Once complete, navigate to Firstpage
        Navigator.of(context)
            .push(
          MaterialPageRoute(builder: (_) => Firstpage()),
        )
            .then((_) {
          setState(() {
            _progressValue = 0.0;
          });
        });

        return false; // Stop the loop
      }
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _progressValue += 0.03; // Increment progress
      });

      return true; // Continue the loop
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 240, 241),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    const Text(
                      'Stand Out. Get Hired',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 83, 82, 82),
                      ),
                    ),
                    const Text(
                      'Redefine Your Future',
                      style: TextStyle(fontSize: 18),
                    ),
                    Center(
                      child: Image.asset('assets/images/CVBUILDER_PICTURE.png'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed:
                          _startProgressAndNavigate, // Start progress and navigate
                      child: const Text(
                        "Start your Future",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(
                      value: _progressValue, // Dynamically updated value
                      color: const Color.fromARGB(255, 252, 237, 108),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
