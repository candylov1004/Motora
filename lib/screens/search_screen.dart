// ============================================================
// lib/screens/search_screen.dart
// 통합 검색 화면 - 브랜드/모델명/연료/구동방식 검색
// ============================================================

import 'package:flutter/material.dart';
import '../models/car_data.dart';
import '../widgets/skeleton.dart';
import 'car_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _query = '';
  bool _searching = false;

  // 필터 상태
  String _filterFuel = '전체';
  String _filterDrive = '전체';

  static const _fuels = ['전체', '가솔린', '디젤', '전기', '하이브리드', '수소'];
  static const _drives = ['전체', 'AWD', 'RWD', 'FWD', '4WD'];

  // 최근 검색어
  final List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    // 자동으로 키보드 올리기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // ── 검색 결과 필터링 ─────────────────────────────────────
  List<({CarBrand brand, CarModel model})> get _results {
    if (_query.trim().isEmpty &&
        _filterFuel == '전체' &&
        _filterDrive == '전체') return [];

    final q = _query.trim().toLowerCase();
    final results = <({CarBrand brand, CarModel model})>[];

    for (final brand in carBrands) {
      for (final model in brand.models) {
        // 검색어 매칭
        final matchQuery = q.isEmpty ||
            brand.name.toLowerCase().contains(q) ||
            model.name.toLowerCase().contains(q) ||
            model.tagline.toLowerCase().contains(q) ||
            model.fuel.toLowerCase().contains(q) ||
            model.drive.toLowerCase().contains(q);

        // 연료 필터
        final matchFuel = _filterFuel == '전체' ||
            model.fuel.contains(_filterFuel);

        // 구동 필터
        final matchDrive = _filterDrive == '전체' ||
            model.drive.contains(_filterDrive);

        if (matchQuery && matchFuel && matchDrive) {
          results.add((brand: brand, model: model));
        }
      }
    }
    return results;
  }

  void _onSearch(String value) async {
    setState(() { _query = value; _searching = true; });
    // 검색 디바운스 (300ms)
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) setState(() => _searching = false);
  }

  void _addRecentSearch(String q) {
    if (q.trim().isEmpty) return;
    setState(() {
      _recentSearches.remove(q);
      _recentSearches.insert(0, q);
      if (_recentSearches.length > 8) _recentSearches.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(child: Column(children: [
        // ── 검색 입력 바 ────────────────────────────────────
        _buildSearchBar(context),
        // ── 필터 바 ─────────────────────────────────────────
        _buildFilterBar(),
        // ── 콘텐츠 ──────────────────────────────────────────
        Expanded(child: _query.isEmpty &&
            _filterFuel == '전체' && _filterDrive == '전체'
          ? _buildInitialView()
          : _searching
            ? _buildSearchingSkeleton()
            : _buildResults()),
      ])),
    );
  }

  // ── 검색 입력 바 ──────────────────────────────────────────
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      child: Row(children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6FA),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE8ECF0)),
            ),
            child: const Icon(Icons.arrow_back_ios_rounded,
                color: Color(0xFF1A1A2E), size: 18),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE8ECF0)),
            ),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: _onSearch,
              onSubmitted: (v) => _addRecentSearch(v),
              style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
              decoration: InputDecoration(
                hintText: "브랜드, 모델명, 연료, 구동방식 검색",
                hintStyle: const TextStyle(
                    fontSize: 13, color: Color(0xFFBCC3CE)),
                prefixIcon: const Icon(Icons.search_rounded,
                    color: Color(0xFFBCC3CE), size: 20),
                suffixIcon: _query.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        _controller.clear();
                        setState(() => _query = '');
                      },
                      child: const Icon(Icons.cancel_rounded,
                          color: Color(0xFFBCC3CE), size: 18))
                  : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  // ── 필터 바 ───────────────────────────────────────────────
  Widget _buildFilterBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          // 연료 필터
          ..._fuels.map((f) => _filterChip(
            f, _filterFuel == f,
            () => setState(() => _filterFuel = f),
          )),
          Container(width: 1, height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: const Color(0xFFE8ECF0)),
          // 구동 필터
          ..._drives.map((d) => _filterChip(
            d, _filterDrive == d,
            () => setState(() => _filterDrive = d),
          )),
        ]),
      ),
    );
  }

  Widget _filterChip(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(right: 7),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF378ADD) : const Color(0xFFF4F6FA),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active
                ? const Color(0xFF378ADD) : const Color(0xFFE8ECF0)),
        ),
        child: Text(label, style: TextStyle(
          fontSize: 12,
          color: active ? Colors.white : const Color(0xFF5A6478),
          fontWeight: active ? FontWeight.w600 : FontWeight.normal,
        )),
      ),
    );
  }

  // ── 초기 화면 (최근 검색어 + 추천) ──────────────────────
  Widget _buildInitialView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 최근 검색어
        if (_recentSearches.isNotEmpty) ...[
          _sectionHeader("최근 검색어", onClear: () {
            setState(() => _recentSearches.clear());
          }),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8,
            children: _recentSearches.map((s) => GestureDetector(
              onTap: () {
                _controller.text = s;
                setState(() => _query = s);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE8ECF0)),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.history_rounded,
                      size: 14, color: Color(0xFFBCC3CE)),
                  const SizedBox(width: 5),
                  Text(s, style: const TextStyle(
                      fontSize: 13, color: Color(0xFF5A6478))),
                ]),
              ),
            )).toList(),
          ),
          const SizedBox(height: 24),
        ],

        // 추천 검색어
        _sectionHeader("추천 검색"),
        const SizedBox(height: 10),
        Wrap(spacing: 8, runSpacing: 8,
          children: [
            '전기차', '고성능', 'SUV', '독일차', '국산차', '하이브리드',
            'AWD', '슈퍼카', '세단', '픽업트럭',
          ].map((s) => GestureDetector(
            onTap: () {
              _controller.text = s;
              setState(() => _query = s);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFF378ADD).withOpacity(0.07),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: const Color(0xFF378ADD).withOpacity(0.2)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.trending_up_rounded,
                    size: 14, color: Color(0xFF378ADD)),
                const SizedBox(width: 5),
                Text(s, style: const TextStyle(
                    fontSize: 13, color: Color(0xFF378ADD),
                    fontWeight: FontWeight.w500)),
              ]),
            ),
          )).toList(),
        ),
        const SizedBox(height: 24),

        // 인기 모델
        _sectionHeader("인기 모델 TOP 6"),
        const SizedBox(height: 10),
        ...[
          ('현대', 'IONIQ 6'), ('기아', 'EV6 GT'),
          ('BMW', 'M4 Competition'), ('Tesla', 'Model 3'),
          ('Porsche', '911 GT3'), ('Mercedes', 'S-Class'),
        ].map((pair) {
          final brand = carBrands.firstWhere(
            (b) => b.name == pair.$1, orElse: () => carBrands.first);
          final model = brand.models.firstWhere(
            (m) => m.name == pair.$2, orElse: () => brand.models.first);
          return _popularModelCard(brand, model);
        }),
      ],
    );
  }

  Widget _popularModelCard(CarBrand brand, CarModel model) {
    final color = Color(brand.colorValue);
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => CarDetailScreen(brand: brand, model: model))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE8ECF0)),
          boxShadow: const [BoxShadow(color: Color(0x06000000),
              blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: Row(children: [
          Container(width: 4, height: 44,
            decoration: BoxDecoration(color: color,
                borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(brand.name, style: TextStyle(
                  fontSize: 11, color: color, fontWeight: FontWeight.w600)),
              Text(model.name, style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E))),
            ],
          )),
          Text(model.price, style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: color)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 13, color: Color(0xFFBCC3CE)),
        ]),
      ),
    );
  }

  // ── 검색 결과 ─────────────────────────────────────────────
  Widget _buildResults() {
    final results = _results;

    if (results.isEmpty) {
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64,
              color: Colors.grey.withOpacity(0.3)),
          const SizedBox(height: 16),
          const Text("검색 결과가 없어요",
              style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6))),
          const SizedBox(height: 8),
          Text("'$_query'에 대한 결과를 찾을 수 없습니다",
              style: const TextStyle(fontSize: 13, color: Color(0xFFBCC3CE))),
        ],
      ));
    }

    return Column(children: [
      // 결과 수
      Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
        color: const Color(0xFFF4F6FA),
        child: Text("검색 결과 ${results.length}개",
          style: const TextStyle(fontSize: 12, color: Color(0xFF8A94A6),
              fontWeight: FontWeight.w500)),
      ),
      // 결과 리스트
      Expanded(child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
        itemCount: results.length,
        itemBuilder: (context, i) {
          final item = results[i];
          return _buildResultCard(item.brand, item.model);
        },
      )),
    ]);
  }

  Widget _buildResultCard(CarBrand brand, CarModel model) {
    final color = Color(brand.colorValue);
    final q = _query.toLowerCase();

    return GestureDetector(
      onTap: () {
        _addRecentSearch(_query);
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => CarDetailScreen(brand: brand, model: model)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8ECF0)),
          boxShadow: const [BoxShadow(color: Color(0x08000000),
              blurRadius: 8, offset: Offset(0, 3))],
        ),
        child: Column(children: [
          // 상단 컬러 바
          Container(height: 4, decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)))),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 브랜드명 (하이라이트)
                  _highlightText(brand.name, q,
                      const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                      TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                          color: color)),
                  const SizedBox(height: 3),
                  // 모델명 (하이라이트)
                  _highlightText(model.name, q,
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E)),
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                          color: color,
                          backgroundColor: color.withOpacity(0.1))),
                  const SizedBox(height: 3),
                  Text(model.tagline,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF8A94A6))),
                  const SizedBox(height: 8),
                  // 스펙 태그
                  Wrap(spacing: 6, runSpacing: 4, children: [
                    _tag(model.fuel, Icons.local_gas_station_rounded),
                    _tag(model.drive, Icons.settings_rounded),
                    _tag("${model.hp}hp", Icons.speed_rounded),
                  ]),
                ],
              )),
              const SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(model.price,
                  style: TextStyle(fontSize: 13,
                      fontWeight: FontWeight.bold, color: color)),
                const SizedBox(height: 8),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 14, color: Colors.grey.shade300),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }

  /// 검색어 하이라이트 텍스트
  Widget _highlightText(String text, String query,
      TextStyle normal, TextStyle highlight) {
    if (query.isEmpty) return Text(text, style: normal);
    final lower = text.toLowerCase();
    final idx = lower.indexOf(query);
    if (idx == -1) return Text(text, style: normal);

    return RichText(text: TextSpan(children: [
      if (idx > 0)
        TextSpan(text: text.substring(0, idx), style: normal),
      TextSpan(text: text.substring(idx, idx + query.length), style: highlight),
      if (idx + query.length < text.length)
        TextSpan(text: text.substring(idx + query.length), style: normal),
    ]));
  }

  Widget _tag(String label, IconData icon) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(
      color: const Color(0xFFF4F6FA),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: const Color(0xFFE8ECF0)),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 11, color: const Color(0xFF8A94A6)),
      const SizedBox(width: 3),
      Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF8A94A6))),
    ]),
  );

  Widget _buildSearchingSkeleton() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      itemCount: 6,
      itemBuilder: (_, __) => const SearchResultSkeleton(),
    );
  }

  Widget _sectionHeader(String title, {VoidCallback? onClear}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(fontSize: 14,
          fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
      if (onClear != null)
        GestureDetector(onTap: onClear,
          child: const Text("전체 삭제",
            style: TextStyle(fontSize: 12, color: Color(0xFFBCC3CE)))),
    ],
  );
}
