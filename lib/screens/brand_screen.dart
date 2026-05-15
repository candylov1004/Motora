// ============================================================
// lib/screens/brand_screen.dart
// Supabase에서 브랜드 데이터 로드 + 라이트 테마
// ============================================================

import 'package:flutter/material.dart';
import '../models/car_data.dart';
import '../services/supabase_service.dart';
import '../widgets/brand_logo.dart';
import '../widgets/skeleton.dart';
import 'model_list_screen.dart';
import 'search_screen.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  List<CarBrand> _brands = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBrands();
  }

  Future<void> _loadBrands() async {
    setState(() { _loading = true; _error = null; });
    try {
      final brands = await SupabaseService.fetchAllBrands();
      if (mounted) setState(() { _brands = brands; _loading = false; });
    } catch (e) {
      if (mounted) setState(() { _error = '데이터를 불러올 수 없어요'; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(child: Column(children: [
        _buildHeader(context),
        Expanded(child: _loading
          ? _buildSkeleton()
          : _error != null
            ? _buildError()
            : _buildBrandGrid(context)),
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
              decoration: BoxDecoration(color: const Color(0xFFE24B4A),
                  borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 8),
            const Text("AUTOMOA", style: TextStyle(fontSize: 22,
                fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), letterSpacing: 1)),
          ]),
          const SizedBox(height: 4),
          Text(_loading
            ? "데이터 로딩 중..."
            : "${_brands.length}개 브랜드 · ${_brands.fold(0, (s, b) => s + b.models.length)}개 모델",
            style: const TextStyle(fontSize: 12, color: Color(0xFF8A94A6))),
        ]),
        Row(children: [
          // 새로고침 버튼
          GestureDetector(
            onTap: () { SupabaseService.clearCache(); _loadBrands(); },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6FA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE8ECF0))),
              child: const Icon(Icons.refresh_rounded, color: Color(0xFF5A6478), size: 20)),
          ),
          // 검색 버튼
          GestureDetector(
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SearchScreen())),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6FA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE8ECF0))),
              child: const Icon(Icons.search_rounded, color: Color(0xFF5A6478), size: 20)),
          ),
        ]),
      ]),
    );
  }

  // 로딩 스켈레톤
  Widget _buildSkeleton() {
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12,
      childAspectRatio: 1.45,
      children: List.generate(8, (_) => const BrandCardSkeleton()),
    );
  }

  // 에러 화면
  Widget _buildError() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.wifi_off_rounded, size: 64, color: Color(0xFFBCC3CE)),
      const SizedBox(height: 16),
      Text(_error ?? '오류 발생', style: const TextStyle(fontSize: 15, color: Color(0xFF8A94A6))),
      const SizedBox(height: 20),
      ElevatedButton.icon(
        onPressed: _loadBrands,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF378ADD), foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        icon: const Icon(Icons.refresh_rounded, size: 18),
        label: const Text("다시 시도")),
    ]));
  }

  Widget _buildBrandGrid(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async { SupabaseService.clearCache(); await _loadBrands(); },
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 12,
          mainAxisSpacing: 12, childAspectRatio: 1.45),
        itemCount: _brands.length,
        itemBuilder: (context, i) => _buildBrandCard(context, _brands[i]),
      ),
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
          boxShadow: const [BoxShadow(color: Color(0x0C000000),
              blurRadius: 10, offset: Offset(0, 4))]),
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
