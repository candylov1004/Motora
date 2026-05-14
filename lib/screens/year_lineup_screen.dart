// ============================================================
// lib/screens/year_lineup_screen.dart
// 연도별 라인업 화면
// ============================================================

import 'package:flutter/material.dart';
import '../models/car_data.dart';
import '../models/year_lineup.dart';

class YearLineupScreen extends StatefulWidget {
  final CarBrand brand;
  final CarModel model;

  const YearLineupScreen({
    super.key,
    required this.brand,
    required this.model,
  });

  @override
  State<YearLineupScreen> createState() => _YearLineupScreenState();
}

class _YearLineupScreenState extends State<YearLineupScreen> {
  int _selectedYear = -1; // -1 = 전체보기

  Color get brandColor => Color(widget.brand.colorValue);

  @override
  Widget build(BuildContext context) {
    final lineup = findLineup(widget.brand.name, widget.model.name);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
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
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.model.name,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E))),
          Text("연도별 라인업",
              style: TextStyle(fontSize: 12, color: brandColor)),
        ]),
      ),
      body: lineup == null
          ? _buildNoData()
          : _buildLineupContent(lineup),
    );
  }

  // ── 데이터 없을 때 ────────────────────────────────────────
  Widget _buildNoData() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.history_rounded,
            size: 64, color: brandColor.withOpacity(0.3)),
        const SizedBox(height: 16),
        const Text("연도별 데이터를 준비 중입니다",
            style: TextStyle(fontSize: 15, color: Color(0xFF8A94A6))),
        const SizedBox(height: 8),
        Text(widget.model.name,
            style: TextStyle(fontSize: 13, color: brandColor,
                fontWeight: FontWeight.w600)),
      ]),
    );
  }

  // ── 라인업 메인 콘텐츠 ───────────────────────────────────
  Widget _buildLineupContent(ModelLineup lineup) {
    final years = lineup.years;

    return Column(children: [
      // ── 연도 선택 탭 ─────────────────────────────────────
      _buildYearSelector(years),

      // ── 콘텐츠 ───────────────────────────────────────────
      Expanded(
        child: _selectedYear == -1
            ? _buildAllYears(years)
            : _buildYearDetail(
                years.firstWhere((y) => y.year == _selectedYear)),
      ),
    ]);
  }

  // ── 연도 선택 바 ─────────────────────────────────────────
  Widget _buildYearSelector(List<YearSpec> years) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          // 전체보기
          _yearChip(-1, "전체"),
          const SizedBox(width: 8),
          ...years.map((y) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _yearChip(y.year, y.year.toString()),
          )),
        ]),
      ),
    );
  }

  Widget _yearChip(int year, String label) {
    final active = _selectedYear == year;
    return GestureDetector(
      onTap: () => setState(() => _selectedYear = year),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? brandColor : const Color(0xFFF4F6FA),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? brandColor : const Color(0xFFE8ECF0)),
        ),
        child: Text(label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            color: active ? Colors.white : const Color(0xFF5A6478),
          )),
      ),
    );
  }

  // ── 전체 연도 타임라인 ───────────────────────────────────
  Widget _buildAllYears(List<YearSpec> years) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: years.length,
      itemBuilder: (context, i) {
        final y = years[i];
        final isLast = i == years.length - 1;
        return GestureDetector(
          onTap: () => setState(() => _selectedYear = y.year),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 타임라인 선
              Column(children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: _yearBadgeColor(y),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: _yearBadgeIcon(y)),
                ),
                if (!isLast)
                  Container(width: 2, height: 60,
                      color: const Color(0xFFE8ECF0)),
              ]),
              const SizedBox(width: 12),
              // 카드
              Expanded(child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE8ECF0)),
                  boxShadow: const [BoxShadow(
                      color: Color(0x08000000), blurRadius: 6,
                      offset: Offset(0, 2))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 연도 + 배지
                    Row(children: [
                      Text("${y.year}년",
                        style: TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold, color: brandColor)),
                      const SizedBox(width: 8),
                      if (y.isNewGen)
                        _badge("풀체인지", Colors.red),
                      if (y.isFacelift && !y.isNewGen)
                        _badge("페이스리프트", Colors.orange),
                    ]),
                    const SizedBox(height: 4),
                    Text(y.trim,
                      style: const TextStyle(fontSize: 13,
                          color: Color(0xFF5A6478))),
                    const SizedBox(height: 10),
                    // 핵심 스펙
                    Row(children: [
                      _miniSpec("${y.hp}hp", "출력"),
                      _miniSpec("${y.z100}s", "0→100"),
                      _miniSpec("${y.topSpeed}km", "최고속"),
                    ]),
                    const SizedBox(height: 10),
                    // 주요 변경사항 (첫 2개만)
                    ...y.changes.take(2).map((c) => Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(margin: const EdgeInsets.only(top: 5),
                            width: 5, height: 5,
                            decoration: BoxDecoration(
                              color: brandColor, shape: BoxShape.circle)),
                          const SizedBox(width: 6),
                          Expanded(child: Text(c,
                            style: const TextStyle(fontSize: 12,
                                color: Color(0xFF5A6478)))),
                        ]),
                    )),
                    if (y.changes.length > 2)
                      Text("외 ${y.changes.length - 2}개 변경사항 →",
                        style: TextStyle(fontSize: 11, color: brandColor)),
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }

  // ── 특정 연도 상세 ────────────────────────────────────────
  Widget _buildYearDetail(YearSpec y) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 헤더 카드
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: brandColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("${y.year}년형",
                style: const TextStyle(fontSize: 22,
                    fontWeight: FontWeight.bold, color: Colors.white)),
              Row(children: [
                if (y.isNewGen) _badge("풀체인지", Colors.white.withOpacity(0.3)),
                if (y.isFacelift && !y.isNewGen)
                  _badge("페이스리프트", Colors.white.withOpacity(0.3)),
              ]),
            ]),
            const SizedBox(height: 4),
            Text(y.trim,
              style: const TextStyle(fontSize: 14, color: Colors.white70)),
            const SizedBox(height: 12),
            Text(y.price,
              style: const TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold, color: Colors.white)),
          ]),
        ),
        const SizedBox(height: 14),

        // 스펙 그리드
        _sectionTitle("성능 스펙"),
        const SizedBox(height: 8),
        GridView.count(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,
          childAspectRatio: 2.0,
          children: [
            _specCard("최고 출력", "${y.hp}", "hp"),
            _specCard("0→100", "${y.z100}", "초"),
            _specCard("최고 속도", "${y.topSpeed}", "km/h"),
            _specCard("최대 토크", "${y.torque}", "kgf·m"),
          ],
        ),
        const SizedBox(height: 14),

        // 파워트레인
        _sectionTitle("파워트레인"),
        const SizedBox(height: 8),
        _infoTable([
          ("엔진", y.engine),
          ("변속기", y.transmission),
          ("구동방식", y.drive),
        ]),
        const SizedBox(height: 14),

        // 변경사항
        _sectionTitle("주요 변경사항"),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE8ECF0)),
          ),
          child: Column(
            children: y.changes.asMap().entries.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 22, height: 22,
                  decoration: BoxDecoration(
                    color: brandColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text("${e.key + 1}",
                    style: TextStyle(fontSize: 11,
                        fontWeight: FontWeight.bold, color: brandColor))),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(e.value,
                  style: const TextStyle(fontSize: 13,
                      color: Color(0xFF1A1A2E), height: 1.4))),
              ]),
            )).toList(),
          ),
        ),
      ],
    );
  }

  // ── 재사용 위젯 ────────────────────────────────────────────

  Color _yearBadgeColor(YearSpec y) {
    if (y.isNewGen) return Colors.red;
    if (y.isFacelift) return Colors.orange;
    return brandColor;
  }

  Widget _yearBadgeIcon(YearSpec y) {
    if (y.isNewGen) return const Icon(Icons.star_rounded, color: Colors.white, size: 18);
    if (y.isFacelift) return const Icon(Icons.refresh_rounded, color: Colors.white, size: 18);
    return const Icon(Icons.circle, color: Colors.white, size: 10);
  }

  Widget _badge(String label, Color bg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
    child: Text(label,
      style: const TextStyle(fontSize: 10, color: Colors.white,
          fontWeight: FontWeight.bold)),
  );

  Widget _miniSpec(String value, String label) => Expanded(
    child: Column(children: [
      Text(value, style: TextStyle(fontSize: 14,
          fontWeight: FontWeight.bold, color: brandColor)),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF8A94A6))),
    ]),
  );

  Widget _specCard(String label, String value, String unit) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE8ECF0)),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF8A94A6))),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(value, style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold, color: brandColor)),
          const SizedBox(width: 2),
          Padding(padding: const EdgeInsets.only(bottom: 2),
            child: Text(unit, style: const TextStyle(fontSize: 10, color: Color(0xFF8A94A6)))),
        ]),
      ]),
  );

  Widget _infoTable(List<(String, String)> items) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFE8ECF0)),
    ),
    child: Column(children: items.asMap().entries.map((e) {
      final isLast = e.key == items.length - 1;
      return Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(e.value.$1,
              style: const TextStyle(fontSize: 13, color: Color(0xFF8A94A6))),
            Flexible(child: Text(e.value.$2,
              style: const TextStyle(fontSize: 13,
                  fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E)),
              textAlign: TextAlign.end)),
          ]),
        ),
        if (!isLast) const Divider(height: 1, color: Color(0xFFF4F6FA),
            indent: 16, endIndent: 16),
      ]);
    }).toList()),
  );

  Widget _sectionTitle(String title) => Text(title,
    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
        color: Color(0xFF1A1A2E)));
}
