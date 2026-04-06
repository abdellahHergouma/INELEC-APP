import 'package:flutter/material.dart';

class GradePlannerScreen extends StatelessWidget {
  const GradePlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, size: 30),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.school, color: Color(0xFF701B99), size: 30),
            SizedBox(width: 8),
            Text('Grade Planner'),
          ],
        ),
      ),
      body: const Center(
        child: Text('Grade Planner Screen', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
