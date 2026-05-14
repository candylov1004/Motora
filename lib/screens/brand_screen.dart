// ============================================================
// lib/screens/brand_screen.dart - 브랜드 로고 + 라이트 테마
// ============================================================

import 'package:flutter/material.dart';
import '../models/car_data.dart';
import '../widgets/brand_logo.dart';
import 'model_list_screen.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(child: Column(children: [
        _buildHeader(),
        Expanded(child: _buildBrandGrid(context)),
      ])),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 4, height: 22,
              decoration: BoxDecoration(color: const Color(0xFFE24B4A), borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 8),
            const Text("MOTORA", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E), letterSpacing: 2)),
          ]),
          const SizedBox(height: 4),
          Text("${carBrands.length}개 브랜드 · ${carBrands.fold(0, (s, b) => s + b.models.length)}개 모델",
            style: const TextStyle(fontSize: 12, color: Color(0xFF8A94A6))),
        ]),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE8ECF0)),
          ),
          child: const Icon(Icons.search_rounded, color: Color(0xFF5A6478), size: 20),
        ),
      ]),
    );
  }

  Widget _buildBrandGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.45),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8ECF0)),
          boxShadow: const [BoxShadow(color: Color(0x0C000000), blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Column(children: [
          // 상단 컬러 바
          Container(height: 5, decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)))),
          Expanded(child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 로고 + 브랜드명
                Row(children: [
                  BrandLogo(brandName: brand.name, size: 28, color: color),
                  const SizedBox(width: 8),
                  Expanded(child: Text(brand.name,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E)),
                    overflow: TextOverflow.ellipsis)),
                ]),
                // 모델 수 + 화살표
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.10), borderRadius: BorderRadius.circular(20)),
                    child: Text("${brand.models.length}개 모델",
                      style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600))),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: color.withOpacity(0.10), shape: BoxShape.circle),
                    child: Icon(Icons.arrow_forward_rounded, color: color, size: 13)),
                ]),
              ]),
          )),
        ]),
      ),
    );
  }

  Widget _buildNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE8ECF0))),
        boxShadow: [BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, -2))],
      ),
      child: SafeArea(top: false, child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _navItem(Icons.grid_view_rounded, "브랜드", true),
          _navItem(Icons.compare_arrows_rounded, "비교", false),
          _navItem(Icons.favorite_border_rounded, "즐겨찾기", false),
          _navItem(Icons.directions_car_outlined, "내 차", false),
        ]),
      )),
    );
  }

  Widget _navItem(IconData icon, String label, bool active) {
    const color = Color(0xFF378ADD);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 22, color: active ? color : const Color(0xFFBCC3CE)),
      const SizedBox(height: 3),
      Text(label, style: TextStyle(fontSize: 10,
        color: active ? color : const Color(0xFFBCC3CE),
        fontWeight: active ? FontWeight.w600 : FontWeight.normal)),
    ]);
  }
}
