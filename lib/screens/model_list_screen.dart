// ============================================================
// lib/screens/model_list_screen.dart
// 브랜드별 모델 목록 - 라이트 테마
// ============================================================

import 'package:flutter/material.dart';
import '../models/car_data.dart';
import '../services/image_service.dart';
import '../widgets/brand_logo.dart';
import 'car_detail_screen.dart';

class ModelListScreen extends StatefulWidget {
  final CarBrand brand;
  const ModelListScreen({super.key, required this.brand});

  @override
  State<ModelListScreen> createState() => _ModelListScreenState();
}

class _ModelListScreenState extends State<ModelListScreen> {
  final Map<String, String?> _thumbnails = {};

  @override
  void initState() {
    super.initState();
    _loadThumbnails();
  }

  Future<void> _loadThumbnails() async {
    for (final model in widget.brand.models) {
      final urls = await ImageService.fetchCarImages(
        '${widget.brand.name} ${model.name}', count: 1);
      if (mounted && urls.isNotEmpty) {
        setState(() => _thumbnails[model.name] = urls.first);
      }
    }
  }

  Color get brandColor => Color(widget.brand.colorValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: CustomScrollView(
        slivers: [
          // ── 상단 앱바 ──────────────────────────────────────
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            shadowColor: const Color(0x1A000000),
            surfaceTintColor: Colors.white,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6FA),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE8ECF0)),
                ),
                child: const Icon(Icons.arrow_back_ios_rounded,
                    color: Color(0xFF1A1A2E), size: 18),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(width: 3, height: 18,
                      decoration: BoxDecoration(
                        color: brandColor,
                        borderRadius: BorderRadius.circular(2),
                      )),
                    const SizedBox(width: 7),
                    Text(widget.brand.name,
                      style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      )),
                  ]),
                  const SizedBox(height: 3),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("${widget.brand.models.length}개 모델",
                      style: TextStyle(fontSize: 12, color: brandColor,
                          fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: brandColor.withOpacity(0.15), width: 2),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(Icons.directions_car_rounded,
                        color: brandColor.withOpacity(0.08), size: 100),
                  ),
                ),
              ),
            ),
          ),

          // ── 모델 카드 리스트 ──────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _buildModelCard(
                    context, widget.brand.models[i], i),
                childCount: widget.brand.models.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModelCard(BuildContext context, CarModel model, int index) {
    final thumbUrl = _thumbnails[model.name];
    final color = brandColor;

    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (_) =>
            CarDetailScreen(brand: widget.brand, model: model))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8ECF0), width: 1),
          boxShadow: const [
            BoxShadow(color: Color(0x0C000000), blurRadius: 10, offset: Offset(0, 4)),
          ],
        ),
        child: Column(children: [
          // ── 차량 이미지 ──────────────────────────────────
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Stack(children: [
              SizedBox(
                height: 190,
                width: double.infinity,
                child: thumbUrl != null
                  ? Image.network(thumbUrl, fit: BoxFit.cover,
                      loadingBuilder: (_, child, progress) =>
                        progress == null ? child : _imagePlaceholder(color, model.name),
                      errorBuilder: (_, __, ___) => _imagePlaceholder(color, model.name))
                  : _imagePlaceholder(color, model.name),
              ),
              // 브랜드 컬러 그라데이션 오버레이 (하단)
              Positioned.fill(child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.45)],
                    stops: const [0.5, 1.0],
                  ),
                ),
              )),
              // 모델명 오버레이
              Positioned(bottom: 12, left: 14, right: 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.name,
                          style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                          )),
                        Text(model.tagline,
                          style: const TextStyle(fontSize: 11, color: Colors.white70)),
                      ],
                    )),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(model.price,
                        style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    ),
                  ],
                ),
              ),
            ]),
          ),

          // ── 스펙 정보 영역 ──────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(children: [
              // 핵심 스펙 4개
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEEF0F4)),
                ),
                child: Row(children: [
                  _specBadge("${model.hp}", "hp", "출력", color),
                  _divider(),
                  _specBadge("${model.z100}s", "", "0→100", color),
                  _divider(),
                  _specBadge("${model.topSpeed}", "km", "최고속", color),
                  _divider(),
                  _specBadge(model.drive, "", "구동", color),
                ]),
              ),
              const SizedBox(height: 10),

              // 연료 + 상세보기 버튼
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Icon(_fuelIcon(model.fuel), size: 14, color: const Color(0xFF8A94A6)),
                  const SizedBox(width: 5),
                  Text(model.fuel,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF8A94A6))),
                ]),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(children: [
                    Text("상세보기",
                      style: TextStyle(fontSize: 12, color: color,
                          fontWeight: FontWeight.w600)),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward_rounded, size: 13, color: color),
                  ]),
                ),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }

  // 연료 타입 아이콘
  IconData _fuelIcon(String fuel) {
    if (fuel.contains('전기')) return Icons.bolt_rounded;
    if (fuel.contains('하이브리드')) return Icons.eco_rounded;
    if (fuel.contains('디젤')) return Icons.local_gas_station_rounded;
    return Icons.local_gas_station_outlined;
  }

  Widget _specBadge(String value, String unit, String label, Color color) {
    return Expanded(
      child: Column(children: [
        RichText(text: TextSpan(children: [
          TextSpan(text: value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                color: color)),
          if (unit.isNotEmpty)
            TextSpan(text: unit,
              style: const TextStyle(fontSize: 10, color: Color(0xFF8A94A6))),
        ])),
        const SizedBox(height: 2),
        Text(label,
          style: const TextStyle(fontSize: 10, color: Color(0xFF8A94A6))),
      ]),
    );
  }

  Widget _divider() => Container(
    width: 1, height: 30,
    color: const Color(0xFFE0E4EA),
  );

  Widget _imagePlaceholder(Color color, String name) {
    return Container(
      color: color.withOpacity(0.06),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.directions_car_rounded, color: color.withOpacity(0.3), size: 52),
        const SizedBox(height: 8),
        Text(name, style: TextStyle(fontSize: 12, color: color.withOpacity(0.5))),
      ]),
    );
  }
}
