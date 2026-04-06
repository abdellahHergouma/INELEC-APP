import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../models/meeting.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarView _calendarView = CalendarView.month;
  final CalendarController _calendarController = CalendarController();

  // Sample data for demonstration
  final List<Meeting> _meetings = <Meeting>[
    Meeting(
      eventName: 'Mathematics Lecture',
      from: DateTime.now().add(const Duration(hours: 9)),
      to: DateTime.now().add(const Duration(hours: 11)),
      background: Colors.blue,
    ),
    Meeting(
      eventName: 'Physics Lab',
      from: DateTime.now().add(const Duration(hours: 14)),
      to: DateTime.now().add(const Duration(hours: 16)),
      background: Colors.green,
    ),
    Meeting(
      eventName: 'Chemistry Tutorial',
      from: DateTime.now().add(const Duration(days: 1, hours: 10)),
      to: DateTime.now().add(const Duration(days: 1, hours: 12)),
      background: Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.school, color: Color(0xFF701B99), size: 30),
            SizedBox(width: 8),
            Text('Timetable Calendar'),
          ],
        ),
        actions: [
          PopupMenuButton<CalendarView>(
            onSelected: (CalendarView view) {
              setState(() {
                _calendarView = view;
                _calendarController.view = view;
              });
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<CalendarView>>[
                  const PopupMenuItem<CalendarView>(
                    value: CalendarView.day,
                    child: Text('Day'),
                  ),
                  const PopupMenuItem<CalendarView>(
                    value: CalendarView.week,
                    child: Text('Week'),
                  ),
                  const PopupMenuItem<CalendarView>(
                    value: CalendarView.workWeek,
                    child: Text('Work Week'),
                  ),
                  const PopupMenuItem<CalendarView>(
                    value: CalendarView.month,
                    child: Text('Month'),
                  ),
                  const PopupMenuItem<CalendarView>(
                    value: CalendarView.timelineDay,
                    child: Text('Timeline Day'),
                  ),
                  const PopupMenuItem<CalendarView>(
                    value: CalendarView.timelineWeek,
                    child: Text('Timeline Week'),
                  ),
                  const PopupMenuItem<CalendarView>(
                    value: CalendarView.timelineWorkWeek,
                    child: Text('Timeline Work Week'),
                  ),
                ],
            icon: const Icon(Icons.view_list),
          ),
        ],
      ),
      body: SfCalendar(
        controller: _calendarController,
        view: _calendarView,
        dataSource: MeetingDataSource(_meetings),
        initialDisplayDate: DateTime.now(),
        timeSlotViewSettings: const TimeSlotViewSettings(
          timeInterval: Duration(minutes: 60),
          timeIntervalHeight: -1, // Auto-fit
          timeRulerSize: 60,
          nonWorkingDays: <int>[DateTime.friday, DateTime.saturday],
        ),
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          showAgenda: true,
        ),
        headerStyle: const CalendarHeaderStyle(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        viewHeaderStyle: const ViewHeaderStyle(
          dayTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        appointmentTextStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        cellBorderColor: Colors.grey.shade300,
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.appointment) {
            // Handle appointment tap
            final Meeting meeting = details.appointments![0];
            _showAppointmentDetails(context, meeting);
          } else if (details.targetElement == CalendarElement.calendarCell) {
            // Handle cell tap - could add new appointment
            _showAddAppointmentDialog(context, details.date!);
          }
        },
        onViewChanged: (ViewChangedDetails details) {
          // Handle view changes if needed
          // View changed details available: details.visibleDates
        },
        firstDayOfWeek: 7, // Sunday
      ),
    );
  }

  void _showAppointmentDetails(BuildContext context, Meeting meeting) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(meeting.eventName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Start: ${meeting.from}'),
              Text('End: ${meeting.to}'),
              Text('All Day: ${meeting.isAllDay}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showAddAppointmentDialog(BuildContext context, DateTime date) {
    // Simple dialog to add new appointment
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Timetable Entry'),
          content: const Text(
            'Add appointment functionality can be implemented here.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
