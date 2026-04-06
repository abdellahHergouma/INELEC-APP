import 'package:flutter/material.dart';

const Color headerColor = Color(0xFF701B99);

class ExamScheduleScreen extends StatelessWidget {
  const ExamScheduleScreen({super.key});

  final List<_ExamEntry> _semester1Exams = const [
    _ExamEntry(
      date: '16',
      month: 'May',
      title: 'Math II',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '17',
      month: 'May',
      title: 'Math III',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '18',
      month: 'May',
      title: 'Chemistry II',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '18',
      month: 'May',
      title: 'Electrical Engineering I',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '19',
      month: 'May',
      title: 'Physics II',
      duration: '90’',
      time: '10:32',
    ),
  ];

  final List<_ExamEntry> _semester2Exams = const [
    _ExamEntry(
      date: '16',
      month: 'May',
      title: 'Math II',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '17',
      month: 'May',
      title: 'Math III',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '18',
      month: 'May',
      title: 'Chemistry II',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '18',
      month: 'May',
      title: 'Electrical Engineering I',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '19',
      month: 'May',
      title: 'Physics II',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '19',
      month: 'May',
      title: 'Electrical Engineering I Lab',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '19',
      month: 'May',
      title: 'Introduction to C programming',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '01',
      month: 'May',
      title: 'Physics II Lab',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '20',
      month: 'May',
      title: 'English II',
      duration: '90’',
      time: '10:32',
    ),
    _ExamEntry(
      date: '21',
      month: 'May',
      title: 'Oral Presentation and information techniques',
      duration: '90’',
      time: '10:32',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Exams Schedule',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: headerColor,
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'SEMESTER 1'),
              Tab(text: 'SEMESTER 2'),
            ],
          ),
        ),
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: TabBarView(
            children: [
              _ExamListView(entries: _semester1Exams),
              _ExamListView(entries: _semester2Exams),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExamListView extends StatelessWidget {
  const _ExamListView({required this.entries});

  final List<_ExamEntry> entries;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.event_note, color: headerColor),
              SizedBox(width: 8),
              Text(
                'Written Exams',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: entries
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: _ExamTile(entry: entry),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExamTile extends StatelessWidget {
  const _ExamTile({required this.entry});

  final _ExamEntry entry;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F4EA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                entry.date,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: headerColor,
                ),
              ),
              Text(
                entry.month,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            entry.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                entry.duration,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              entry.time,
              style: const TextStyle(
                color: headerColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ExamEntry {
  const _ExamEntry({
    required this.date,
    required this.month,
    required this.title,
    required this.duration,
    required this.time,
  });

  final String date;
  final String month;
  final String title;
  final String duration;
  final String time;
}
