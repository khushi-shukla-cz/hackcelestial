import 'package:flutter/material.dart';

class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) => FlutterFlowTheme();

  Color get primary => const Color(0xFF0EA5E9);
  Color get primaryBackground => Colors.white;
  Color get secondaryBackground => const Color(0xFFF1F5F9);
  Color get primaryText => Colors.black;
  Color get secondaryText => Colors.grey;

  TextStyle get titleLarge => const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  TextStyle get headlineMedium => const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle get bodyMedium => const TextStyle(fontSize: 16);
  TextStyle get bodySmall => const TextStyle(fontSize: 14);
  TextStyle get titleMedium => const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  TextStyle get titleSmall => const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
}
