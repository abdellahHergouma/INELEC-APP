import 'package:flutter/material.dart';

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(Icons.school, color: colorScheme.primary, size: 50),
          Text(
            "Assignments",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border.all(color: colorScheme.primary, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAssignmentItem(
                  context,
                  "Electrical Engineering 1",
                  "Due: April 5, 11:59 PM",
                  "Problem_set_3A.pdf",
                ),
                const Divider(height: 30),
                _buildAssignmentItem(
                  context,
                  "Chemistry II",
                  "Due: April 9, 11:59 PM",
                  "Chem_II_Recit4.pdf",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentItem(
    BuildContext context,
    String title,
    String due,
    String fileName,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: colorScheme.onSurface,
          ),
        ),
        Text(
          due,
          style: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary),
          icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
          label: Text(fileName, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
