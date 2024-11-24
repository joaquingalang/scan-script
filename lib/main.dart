import 'package:flutter/material.dart';
import 'package:scan_script/screens/findings_screen.dart';
import 'package:scan_script/screens/home_screen.dart';
import 'package:scan_script/screens/regexp_info_screen.dart';
import 'package:scan_script/screens/test_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
