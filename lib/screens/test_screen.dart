import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(text: 'The quick '),
              TextSpan(
                text: 'red ',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              TextSpan(text: 'fox jumped over the lazy '),
              TextSpan(
                text: 'brown ',
                style:
                TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
              ),
              TextSpan(text: 'dog.'),
            ],
          ),
        ),
      ),
    );
  }
}
