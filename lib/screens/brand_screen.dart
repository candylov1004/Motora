// ============================================================
// lib/screens/brand_screen.dart
// 브랜드 선택 메인 화면
// ============================================================

import 'package:flutter/material.dart';
import '../models/car_data.dart';
import 'model_list_screen.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SafeArea(
        child: Column(children: [
          _buildHeader(),
          Expanded(child: _buildBrandGrid(context)),
        ]),
      ),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  // ── 상단 헤더 ─────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFF0C1B2E), Color(0xFF0A0E1A)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 4, height: 20,
                decoration: BoxDecoration(color: const Color(0xFFE24B4A), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text("MOTORA", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                  color: Colors.white, letterSpacing: 2)),
            ]),
            const SizedBox(height: 4),
            Text("${carBrands.length}개 브랜드 · ${carBrands.fold(0, (s, b) => s + b.models.length)}개 모델",
              style: const TextStyle(fontSize: 12, color: Color(0xFF85B7EB))),
          ]),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.search_rounded, color: Color(0xFF85B7EB), size: 20),
          ),
        ],
      ),
    );
  }

  // ── 브랜드 그리드 ─────────────────────────────────────────
  Widget _buildBrandGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemCount: carBrands.length,
      itemBuilder: (context, i) => _buildBrandCard(context, carBrands[i]),
    );
  }

  Widget _buildBrandCard(BuildContext context, CarBrand brand) {
    final color = Color(brand.colorValue);
    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (_) => ModelListScreen(brand: brand))),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [color.withOpacity(0.25), color.withOpacity(0.08)],
          ),
          border: Border.all(color: color.withOpacity(0.4), width: 0.8),
        ),
        child: Stack(children: [
          // 배경 장식 원
          Positioned(right: -15, top: -15,
            child: Container(width: 70, height: 70,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.1)))),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 브랜드명
                Text(brand.name, style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                // 모델 수 + 화살표
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("${brand.models.length}개 모델",
                      style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, color: color, size: 14),
                ]),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  // ── 하단 네비게이션 바 ─────────────────────────────────────
  Widget _buildNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF111827),
        border: Border(top: BorderSide(color: Color(0xFF1E293B), width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.grid_view_rounded, "브랜드", true),
              _navItem(Icons.compare_arrows_rounded, "비교", false),
              _navItem(Icons.favorite_border_rounded, "즐겨찾기", false),
              _navItem(Icons.person_outline_rounded, "내 차", false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool active) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 22,
        color: active ? const Color(0xFF378ADD) : const Color(0xFF4B5563)),
      const SizedBox(height: 3),
      Text(label, style: TextStyle(fontSize: 10,
        color: active ? const Color(0xFF378ADD) : const Color(0xFF4B5563))),
    ]);
  }
}
