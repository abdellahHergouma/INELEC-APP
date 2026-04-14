import 'package:flutter/material.dart';
import 'timetable_screen.dart';
import 'assignments_screen.dart';
import 'exam_schedule_screen.dart';
import 'grades_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onAssignmentsTap, this.onGradesTap});

  final VoidCallback? onAssignmentsTap;
  final VoidCallback? onGradesTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    final secondaryColor = colorScheme.primaryContainer;
    final accentColor = colorScheme.onPrimary;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(Icons.school, color: accentColor, size: 40),
              ),

              const SizedBox(height: 40),

              // 🔘 Buttons
              _buildMenuButton(context, Icons.grid_view, 'Time Table', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TimetableScreen(),
                  ),
                );
              }),

              _buildMenuButton(context, Icons.access_time, 'Assignments', () {
                if (onAssignmentsTap != null) {
                  onAssignmentsTap!();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AssignmentsScreen(),
                    ),
                  );
                }
              }),

              _buildMenuButton(
                context,
                Icons.calendar_today,
                'Exam Schedule',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExamScheduleScreen(),
                    ),
                  );
                },
              ),

              _buildMenuButton(
                context,
                Icons.calculate,
                'Grade Calculator',
                () {
                  if (onGradesTap != null) {
                    onGradesTap!();
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GradesScreen(),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
