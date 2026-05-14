// lib/main.dart - MOTORA v4 라이트 테마
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/brand_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // 라이트 배경이므로 아이콘 다크
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
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF378ADD),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1A1A2E),
          elevation: 0,
          surfaceTintColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const BrandScreen(),
    );
  }
}
