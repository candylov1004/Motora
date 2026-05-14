// ============================================================
// lib/screens/brand_screen.dart - 브랜드 로고 + 라이트 테마
// 네비게이션 바는 main.dart의 HomeScreen에서 관리
// ============================================================

import 'package:flutter/material.dart';
import '../models/car_data.dart';
import 'search_screen.dart';
import '../widgets/brand_logo.dart';
import 'model_list_screen.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      // bottomNavigationBar 제거 - main.dart HomeScreen에서 통합 관리
      body: SafeArea(child: Column(children: [
        _buildHeader(context),
        Expanded(child: _buildBrandGrid(context)),
      ])),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
              decoration: BoxDecoration(
                color: const Color(0xFFE24B4A),
                borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 8),
            const Text("AUTOMOA", style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E), letterSpacing: 1)),
          ]),
          const SizedBox(height: 4),
          Text("${carBrands.length}개 브랜드 · ${carBrands.fold(0, (s, b) => s + b.models.length)}개 모델",
            style: const TextStyle(fontSize: 12, color: Color(0xFF8A94A6))),
        ]),
        GestureDetector(
          onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const SearchScreen())),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE8ECF0)),
            ),
            child: const Icon(Icons.search_rounded, color: Color(0xFF5A6478), size: 20),
          ),
        ),
      ]),
    );
  }

  Widget _buildBrandGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 12,
        mainAxisSpacing: 12, childAspectRatio: 1.45),
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
          boxShadow: const [BoxShadow(
              color: Color(0x0C000000), blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Column(children: [
          Container(height: 5, decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)))),
          Expanded(child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  BrandLogo(brandName: brand.name, size: 28, color: color),
                  const SizedBox(width: 8),
                  Expanded(child: Text(brand.name,
                    style: const TextStyle(fontSize: 15,
                        fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
                    overflow: TextOverflow.ellipsis)),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(20)),
                    child: Text("${brand.models.length}개 모델",
                      style: TextStyle(fontSize: 11, color: color,
                          fontWeight: FontWeight.w600))),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.10), shape: BoxShape.circle),
                    child: Icon(Icons.arrow_forward_rounded, color: color, size: 13)),
                ]),
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
