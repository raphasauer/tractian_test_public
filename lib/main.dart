import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_test/views/pages/unit_selection_page.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData(
      primaryColor: const Color(0xFF1d357e),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1d357e),
        centerTitle: true,
      ),
    ),
    home: const UnitSelectionPage(),
  ));
}
