// lib/main.dart - 오토모아 v5 (즐겨찾기 + 내 차 + 연도별 라인업)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/brand_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/my_car_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const AutomoahApp());
}

class AutomoahApp extends StatelessWidget {
  const AutomoahApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '오토모아',
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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    BrandScreen(),
    FavoritesScreen(),
    MyCarScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE8ECF0))),
          boxShadow: [BoxShadow(
              color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, -2))],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(0, Icons.grid_view_rounded, Icons.grid_view_rounded, "탐색"),
                _navItem(1, Icons.favorite_rounded, Icons.favorite_border_rounded, "즐겨찾기"),
                _navItem(2, Icons.directions_car_rounded, Icons.directions_car_outlined, "내 차"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final active = _currentIndex == index;
    const color = Color(0xFF378ADD);
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(active ? activeIcon : inactiveIcon,
            size: 24, color: active ? color : const Color(0xFFBCC3CE)),
        const SizedBox(height: 3),
        Text(label, style: TextStyle(
          fontSize: 10,
          color: active ? color : const Color(0xFFBCC3CE),
          fontWeight: active ? FontWeight.w600 : FontWeight.normal,
        )),
      ]),
    );
  }
}
