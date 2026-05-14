// ============================================================
// lib/main.dart
// MOTORA v2 앱 진입점
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/brand_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MotoraApp());
}

class MotoraApp extends StatelessWidget {
  const MotoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOTORA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0E1A),
        colorScheme: const ColorScheme.dark(primary: Color(0xFF378ADD)),
        useMaterial3: true,
      ),
      home: const BrandScreen(),
    );
  }
}
