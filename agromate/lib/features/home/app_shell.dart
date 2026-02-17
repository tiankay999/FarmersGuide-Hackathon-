import 'package:flutter/material.dart';
import 'tabs/chat_tab.dart';
import 'tabs/scan_tab.dart';
import 'tabs/schedule_tab.dart';
import 'tabs/profile_tab.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final pages = const [
    ChatTab(),
    ScanTab(),
    ScheduleTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // Keeps state alive between tabs (important for chat + forms)
        index: index,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.chat_bubble), label: "Chat"),
          NavigationDestination(icon: Icon(Icons.camera_alt), label: "Scan"),
          NavigationDestination(icon: Icon(Icons.event), label: "Schedule"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
