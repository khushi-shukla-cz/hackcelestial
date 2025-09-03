import 'package:flutter/material.dart';
import 'features/dashboard_widget.dart';

void main() {
  runApp(const HumanAidApp());
}

class HumanAidApp extends StatelessWidget {
  const HumanAidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Human Aid',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const DashboardWidget(),
    );
  }
}
