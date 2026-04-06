import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      id: '1',
      title: 'Assignment Due',
      message: 'Mathematics assignment is due tomorrow at 11:59 PM',
      time: '2 hours ago',
      type: NotificationType.assignment,
    ),
    _NotificationItem(
      id: '2',
      title: 'Grade Posted',
      message: 'Your Physics quiz grade has been posted',
      time: '1 day ago',
      type: NotificationType.grade,
    ),
    _NotificationItem(
      id: '3',
      title: 'Class Reminder',
      message: 'Chemistry lab starts in 30 minutes',
      time: '30 min ago',
      type: NotificationType.reminder,
    ),
    _NotificationItem(
      id: '4',
      title: 'Exam Schedule',
      message: 'Final exam schedule has been updated',
      time: '2 days ago',
      type: NotificationType.exam,
    ),
  ];

  void _dismissNotification(String id) {
    setState(() {
      _notifications.removeWhere((notification) => notification.id == id);
    });
  }

  void _dismissAllNotifications() {
    setState(() {
      _notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, size: 30),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.school, color: Color(0xFF701B99), size: 30),
            SizedBox(width: 8),
            Text('Notifications'),
          ],
        ),
        actions: [
          if (_notifications.isNotEmpty)
            TextButton(
              onPressed: _dismissAllNotifications,
              child: const Text(
                'Clear All',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No notifications',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Dismissible(
                  key: Key(notification.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _dismissNotification(notification.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${notification.title} dismissed'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            setState(() {
                              _notifications.insert(index, notification);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: _NotificationTile(notification: notification),
                );
              },
            ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});

  final _NotificationItem notification;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getNotificationColor(notification.type),
          child: Icon(
            _getNotificationIcon(notification.type),
            color: Colors.white,
          ),
        ),
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            const SizedBox(height: 4),
            Text(
              notification.time,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
        return Colors.red;
      case NotificationType.grade:
        return Colors.green;
      case NotificationType.reminder:
        return Colors.orange;
      case NotificationType.exam:
        return Colors.blue;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
        return Icons.assignment;
      case NotificationType.grade:
        return Icons.grade;
      case NotificationType.reminder:
        return Icons.alarm;
      case NotificationType.exam:
        return Icons.school;
    }
  }
}

class _NotificationItem {
  const _NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
  });

  final String id;
  final String title;
  final String message;
  final String time;
  final NotificationType type;
}

enum NotificationType { assignment, grade, reminder, exam }
