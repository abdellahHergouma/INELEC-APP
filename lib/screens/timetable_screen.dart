import 'package:flutter/material.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color headerColor = isDarkMode
        ? const Color(0xFF4A2159)
        : const Color(0xFFEEDCFF);
    final Color borderColor = isDarkMode
        ? const Color(0xFF6B3F7A)
        : const Color(0xFFD7B8EE);
    final Color cellColor = isDarkMode
        ? const Color(0xFF2F1940)
        : const Color(0xFFFDF4FF);
    final Color titleColor = isDarkMode ? Colors.white : Colors.black;
    final Color subtitleColor = isDarkMode
        ? const Color(0xFFCFB0E7)
        : const Color(0xFF6F4F92);
    final Color accentColor = const Color(0xFF701B99);

    return Scaffold(
      appBar: AppBar(title: const Text('Time Table'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.schedule, color: Color(0xFF701B99), size: 32),
                const SizedBox(width: 12),
                Text(
                  'Group 4 • L02',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 960,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                  color: cellColor,
                ),
                child: Table(
                  border: TableBorder.symmetric(
                    inside: BorderSide(color: borderColor),
                    outside: BorderSide(color: borderColor),
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    _buildHeaderRow(headerColor, titleColor),
                    _buildPeriodRow(
                      '08:00 - 09:30',
                      'Maths II',
                      'Circuit Analysis',
                      'Intro to C Programming',
                      'Digital Systems',
                      'Electromagnetics',
                      'Control Systems',
                      accentColor,
                      titleColor,
                      subtitleColor,
                      cellColor,
                    ),
                    _buildPeriodRow(
                      '09:40 - 11:10',
                      'Power Systems',
                      '',
                      'Signal Processing',
                      'Electronics II',
                      'Measurements',
                      'Electrical Machines',
                      accentColor,
                      titleColor,
                      subtitleColor,
                      cellColor,
                    ),
                    _buildPeriodRow(
                      '11:20 - 12:50',
                      'Microcontrollers',
                      'Maths II',
                      '',
                      'Embedded Systems',
                      'Network Analysis',
                      '',
                      accentColor,
                      titleColor,
                      subtitleColor,
                      cellColor,
                    ),
                    _buildPeriodRow(
                      '13:00 - 14:30',
                      'Power Electronics',
                      'Instrumentation',
                      'Signals & Systems',
                      '',
                      'Machine Design',
                      'Programming',
                      accentColor,
                      titleColor,
                      subtitleColor,
                      cellColor,
                    ),
                    _buildPeriodRow(
                      '14:40 - 16:10',
                      'Control Labs',
                      'Lab Practice',
                      'Project Work',
                      'Maths II',
                      '',
                      'Communication Systems',
                      accentColor,
                      titleColor,
                      subtitleColor,
                      cellColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Legend',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 10),
            _buildLegendRow(accentColor, 'Lecture name', subtitleColor),
            const SizedBox(height: 4),
            _buildLegendRow(Colors.grey, 'Lecturer', subtitleColor),
            const SizedBox(height: 4),
            _buildLegendRow(Colors.grey.shade500, 'Room / Hall', subtitleColor),
          ],
        ),
      ),
    );
  }

  TableRow _buildHeaderRow(Color backgroundColor, Color textColor) {
    return TableRow(
      decoration: BoxDecoration(color: backgroundColor),
      children: [
        _buildHeaderCell('Time', textColor),
        _buildHeaderCell('Sat', textColor),
        _buildHeaderCell('Sun', textColor),
        _buildHeaderCell('Mon', textColor),
        _buildHeaderCell('Tue', textColor),
        _buildHeaderCell('Wed', textColor),
        _buildHeaderCell('Thu', textColor),
      ],
    );
  }

  TableRow _buildPeriodRow(
    String time,
    String saturday,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    Color accentColor,
    Color titleColor,
    Color subtitleColor,
    Color cellColor,
  ) {
    return TableRow(
      decoration: BoxDecoration(color: cellColor),
      children: [
        _buildTimeCell(time, subtitleColor),
        _buildScheduleCell(
          saturday,
          'Prof. Kader',
          'Room 204',
          accentColor,
          titleColor,
          subtitleColor,
        ),
        _buildScheduleCell(
          sunday,
          'Dr. Laila',
          'Hall A1',
          accentColor,
          titleColor,
          subtitleColor,
        ),
        _buildScheduleCell(
          monday,
          'Eng. Sami',
          'Room 110',
          accentColor,
          titleColor,
          subtitleColor,
        ),
        _buildScheduleCell(
          tuesday,
          'Mme. Nora',
          'Hall B2',
          accentColor,
          titleColor,
          subtitleColor,
        ),
        _buildScheduleCell(
          wednesday,
          'Dr. Fatima',
          'Lab 3',
          accentColor,
          titleColor,
          subtitleColor,
        ),
        _buildScheduleCell(
          thursday,
          'Self-study',
          'Study Area',
          accentColor,
          titleColor,
          subtitleColor,
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }

  Widget _buildTimeCell(String text, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
      ),
    );
  }

  Widget _buildScheduleCell(
    String lecture,
    String teacher,
    String room,
    Color accentColor,
    Color titleColor,
    Color subtitleColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lecture,
            style: TextStyle(fontWeight: FontWeight.w700, color: titleColor),
          ),
          const SizedBox(height: 4),
          Text(teacher, style: TextStyle(color: subtitleColor, fontSize: 12)),
          const SizedBox(height: 2),
          Text(room, style: TextStyle(color: subtitleColor, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildLegendRow(Color dotColor, String text, Color textColor) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Text(text, style: TextStyle(color: textColor)),
      ],
    );
  }
}
