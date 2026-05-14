// ============================================================
// lib/screens/car_detail_screen.dart
// 차량 상세 화면 - 실제 Unsplash 이미지 + 스펙 + 가격
// ============================================================

import 'package:flutter/material.dart';
import '../models/car_data.dart';
import '../services/image_service.dart';

class CarDetailScreen extends StatefulWidget {
  final CarBrand brand;
  final CarModel model;
  const CarDetailScreen({super.key, required this.brand, required this.model});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  // 이미지 목록 상태
  List<String> _exteriorImages = [];
  List<String> _interiorImages = [];
  bool _loadingImages = true;
  int _currentImageIndex = 0;

  // 최대값 상수 (바 차트 정규화)
  static const double maxHp = 1020;
  static const double maxTorque = 130;
  static const double maxSpeed = 400;
  static const double maxZ = 10;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadImages();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Unsplash에서 외관/내관 이미지 로드
  Future<void> _loadImages() async {
    setState(() => _loadingImages = true);
    try {
      final results = await Future.wait([
        ImageService.fetchCarImages(widget.model.exteriorKeyword, count: 4),
        ImageService.fetchCarImages(widget.model.interiorKeyword, count: 4),
      ]);
      if (mounted) {
        setState(() {
          _exteriorImages = results[0];
          _interiorImages = results[1];
          _loadingImages = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loadingImages = false);
    }
  }

  Color get brandColor => Color(widget.brand.colorValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // ── 이미지 슬라이더 상단 영역 ─────────────────────
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFF0C1B2E),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 18),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.favorite_border_rounded, color: Colors.white, size: 18),
                ),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImageSlider(),
            ),
          ),

          // ── 차량명 + 가격 고정 헤더 ───────────────────────
          SliverToBoxAdapter(child: _buildCarHeader()),

          // ── 탭 바 ─────────────────────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              TabBar(
                controller: _tabController,
                indicatorColor: brandColor,
                indicatorWeight: 2.5,
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF6B7280),
                labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                tabs: const [Tab(text: "성능 스펙"), Tab(text: "외관/내관"), Tab(text: "가격 비교")],
              ),
              backgroundColor: const Color(0xFF0A0E1A),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildSpecTab(),
            _buildPhotoTab(),
            _buildPriceTab(),
          ],
        ),
      ),
    );
  }

  // ── 이미지 슬라이더 ───────────────────────────────────────
  Widget _buildImageSlider() {
    final allImages = [..._exteriorImages, ..._interiorImages];

    if (_loadingImages) {
      return Container(
        color: const Color(0xFF0C1B2E),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(color: brandColor, strokeWidth: 2),
          const SizedBox(height: 12),
          const Text("이미지 로딩 중...", style: TextStyle(color: Color(0xFF85B7EB), fontSize: 12)),
        ]),
      );
    }

    if (allImages.isEmpty) {
      return Container(
        color: const Color(0xFF0C1B2E),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.directions_car_rounded, color: brandColor.withOpacity(0.4), size: 64),
          const SizedBox(height: 12),
          Text(widget.model.name, style: TextStyle(color: brandColor, fontSize: 16)),
        ]),
      );
    }

    return Stack(children: [
      // 이미지 페이지뷰
      PageView.builder(
        itemCount: allImages.length,
        onPageChanged: (i) => setState(() => _currentImageIndex = i),
        itemBuilder: (context, i) => Image.network(
          allImages[i], fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: const Color(0xFF0C1B2E),
            child: Icon(Icons.image_not_supported_rounded,
              color: brandColor.withOpacity(0.3), size: 48)),
        ),
      ),

      // 그라데이션 오버레이 (하단)
      Positioned.fill(child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [Colors.transparent, const Color(0xFF0A0E1A).withOpacity(0.8)],
            stops: const [0.5, 1.0],
          ),
        ),
      )),

      // 이미지 인디케이터 + 라벨
      Positioned(bottom: 12, left: 0, right: 0,
        child: Column(children: [
          // 외관/내관 라벨
          if (allImages.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _currentImageIndex < _exteriorImages.length ? "익스테리어" : "인테리어",
                style: const TextStyle(fontSize: 11, color: Colors.white70),
              ),
            ),
          const SizedBox(height: 8),
          // 닷 인디케이터
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(allImages.length, (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: _currentImageIndex == i ? 16 : 5,
              height: 5,
              decoration: BoxDecoration(
                color: _currentImageIndex == i ? brandColor : Colors.white30,
                borderRadius: BorderRadius.circular(3),
              ),
            )),
          ),
        ]),
      ),
    ]);
  }

  // ── 차량명 헤더 ───────────────────────────────────────────
  Widget _buildCarHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      color: const Color(0xFF0A0E1A),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.brand.name,
              style: TextStyle(fontSize: 12, color: brandColor, fontWeight: FontWeight.w600)),
            Text(widget.model.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(widget.model.tagline,
              style: const TextStyle(fontSize: 13, color: Color(0xFF85B7EB))),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Text("시작가", style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
            Text(widget.model.price,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: brandColor)),
          ]),
        ],
      ),
    );
  }

  // ── 성능 스펙 탭 ──────────────────────────────────────────
  Widget _buildSpecTab() {
    final m = widget.model;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 4분할 스펙 카드
        GridView.count(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,
          childAspectRatio: 1.8,
          children: [
            _specCard("최고 출력", "${m.hp}", "hp"),
            _specCard("0→100 km/h", "${m.z100}", "초"),
            _specCard("최대 토크", "${m.torque}", "kgf·m"),
            _specCard("최고 속도", "${m.topSpeed}", "km/h"),
          ],
        ),
        const SizedBox(height: 16),

        // 성능 바 차트
        _buildBarChart(m),
        const SizedBox(height: 16),

        // 상세 정보
        _infoCard([
          ("연료 타입", m.fuel),
          ("구동 방식", m.drive),
          ("최고 출력", "${m.hp} hp"),
          ("최대 토크", "${m.torque} kgf·m"),
          ("최고 속도", "${m.topSpeed} km/h"),
          ("0→100 km/h", "${m.z100}초"),
        ]),
      ],
    );
  }

  // ── 외관/내관 탭 ──────────────────────────────────────────
  Widget _buildPhotoTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 익스테리어
        _sectionTitle("익스테리어", Icons.directions_car_rounded),
        const SizedBox(height: 10),
        if (_loadingImages)
          _loadingGrid()
        else if (_exteriorImages.isEmpty)
          _noImageBox("익스테리어 이미지 없음")
        else
          _imageGrid(_exteriorImages),

        const SizedBox(height: 20),

        // 인테리어
        _sectionTitle("인테리어", Icons.airline_seat_recline_normal_rounded),
        const SizedBox(height: 10),
        if (_loadingImages)
          _loadingGrid()
        else if (_interiorImages.isEmpty)
          _noImageBox("인테리어 이미지 없음")
        else
          _imageGrid(_interiorImages),
      ],
    );
  }

  // ── 가격 비교 탭 ──────────────────────────────────────────
  Widget _buildPriceTab() {
    final m = widget.model;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 트림별 가격
        _sectionTitle("트림별 가격", Icons.monetization_on_rounded),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF1E293B), width: 0.5),
          ),
          child: Column(
            children: m.trims.asMap().entries.map((e) {
              final isLast = e.key == m.trims.length - 1;
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(e.value.name,
                        style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
                    ])),
                    Text(e.value.price,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: brandColor)),
                  ]),
                ),
                if (!isLast) Divider(height: 1, color: Colors.white.withOpacity(0.06), indent: 16, endIndent: 16),
              ]);
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),

        // 딜러 문의 버튼
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: brandColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("딜러 문의하기", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: brandColor,
            side: BorderSide(color: brandColor, width: 0.8),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("시승 예약하기", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  // ── 재사용 위젯 ────────────────────────────────────────────

  Widget _specCard(String label, String value, String unit) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E293B), width: 0.5),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(width: 3),
            Padding(padding: const EdgeInsets.only(bottom: 2),
              child: Text(unit, style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)))),
          ]),
        ],
      ),
    );
  }

  Widget _buildBarChart(CarModel m) {
    final bars = [
      ("출력", "${m.hp} hp", m.hp / maxHp),
      ("토크", "${m.torque} kgf·m", m.torque / maxTorque),
      ("가속 (역순)", "${m.z100}초", 1.0 - (m.z100 / maxZ)),
      ("최고 속도", "${m.topSpeed} km/h", m.topSpeed / maxSpeed),
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1E293B), width: 0.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(children: bars.map((b) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(b.$1, style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
            Text(b.$2, style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
          ]),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: b.$3.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: const Color(0xFF1E293B),
              valueColor: AlwaysStoppedAnimation<Color>(brandColor),
            ),
          ),
        ]),
      )).toList()),
    );
  }

  Widget _infoCard(List<(String, String)> items) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1E293B), width: 0.5),
      ),
      child: Column(children: items.asMap().entries.map((e) {
        final isLast = e.key == items.length - 1;
        return Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(e.value.$1, style: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF))),
              Text(e.value.$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
            ]),
          ),
          if (!isLast) Divider(height: 1, color: Colors.white.withOpacity(0.05), indent: 16, endIndent: 16),
        ]);
      }).toList()),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(children: [
      Icon(icon, color: brandColor, size: 18),
      const SizedBox(width: 8),
      Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
    ]);
  }

  Widget _imageGrid(List<String> urls) {
    return GridView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 1.5),
      itemCount: urls.length,
      itemBuilder: (_, i) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(urls[i], fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: const Color(0xFF111827),
            child: Icon(Icons.image_not_supported_rounded,
              color: brandColor.withOpacity(0.3), size: 32)),
        ),
      ),
    );
  }

  Widget _loadingGrid() {
    return GridView.count(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 1.5,
      children: List.generate(4, (_) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: const Color(0xFF111827),
          child: Center(child: CircularProgressIndicator(color: brandColor, strokeWidth: 2)),
        ),
      )),
    );
  }

  Widget _noImageBox(String msg) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(msg, style: const TextStyle(color: Color(0xFF4B5563)))),
    );
  }
}

// ── 탭바 고정 헤더 델리게이트 ──────────────────────────────
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;
  const _TabBarDelegate(this.tabBar, {required this.backgroundColor});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: backgroundColor, child: tabBar);
  }

  @override double get minExtent => tabBar.preferredSize.height;
  @override double get maxExtent => tabBar.preferredSize.height;
  @override bool shouldRebuild(_TabBarDelegate old) => false;
}
