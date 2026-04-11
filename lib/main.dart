import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Ensure these file names match your actual filenames in lib/screens/
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/modules_screen.dart';
import 'screens/assignments_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/grades_screen.dart'; // This file should contain class GradesScreen
import 'screens/calendar_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Added device preview for easier testing on different screen sizes during development.
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const InelecApp(),
    ),
  );
}

class InelecApp extends StatefulWidget {
  const InelecApp({super.key});

  @override
  State<InelecApp> createState() => _InelecAppState();
}

class _InelecAppState extends State<InelecApp> {
  static const String _themeModeKey = 'theme_mode';

  final ValueNotifier<ThemeMode> _themeModeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
    _themeModeNotifier.addListener(() {
      _saveThemeMode(_themeModeNotifier.value);
    });
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final storedValue = prefs.getString(_themeModeKey);
    final mode = _themeModeFromString(storedValue) ?? ThemeMode.light;
    _themeModeNotifier.value = mode;
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, _themeModeToString(mode));
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  ThemeMode? _themeModeFromString(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _themeModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeModeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'INELEC APP',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF701B99),
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF701B99),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          themeMode: themeMode,
          home: MainNavigationShell(themeModeNotifier: _themeModeNotifier),
        );
      },
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key, required this.themeModeNotifier});

  final ValueNotifier<ThemeMode> themeModeNotifier;

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _navigateTo(Widget screen) {
    // Close the drawer only when it is open.
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context);
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  List<Widget> get _bottomBarScreens => [
    HomeScreen(
      onAssignmentsTap: () => setState(() => _selectedIndex = 2),
      onGradesTap: () => setState(() => _selectedIndex = 4),
    ), // Main Menu with the 4 big buttons
    const ModulesScreen(), // Modules list
    const AssignmentsScreen(), // Assignments view
    const AttendanceScreen(), // Attendance view
    const GradesScreen(), // Grade Calculator / Grades view
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'INELEC APP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => _navigateTo(const NotificationsScreen()),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => _navigateTo(const ProfileScreen()),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF701B99)),
              child: Center(
                child: Icon(Icons.school, color: Colors.white, size: 60),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text('Calendar'),
              onTap: () => _navigateTo(const CalendarScreen()),
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () => _navigateTo(
                SettingsScreen(themeModeNotifier: widget.themeModeNotifier),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _bottomBarScreens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF701B99),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Modules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.co_present_outlined),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll_outlined),
            label: 'Grades',
          ),
        ],
      ),
    );
  }
}
