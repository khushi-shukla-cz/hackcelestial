import 'package:flutter/material.dart';

class DashbaordModel extends ChangeNotifier {
  // Add properties and methods for dashboard state management here
  void dispose() {
    super.dispose();
  }
}

DashbaordModel createModel(BuildContext context, DashbaordModel Function() modelBuilder) {
  return modelBuilder();
}
