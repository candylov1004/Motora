// ============================================================
// lib/screens/car_detail_screen.dart
// 차량 상세 화면 - 라이트 테마
// ============================================================

import 'package:flutter/material.dart';
import '../models/car_data.dart';
import '../services/image_service.dart';
import '../widgets/brand_logo.dart';

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
  List<String> _exteriorImages = [];
  List<String> _interiorImages = [];
  bool _loadingImages = true;
  int _currentImageIndex = 0;

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
    } catch (_) {
      if (mounted) setState(() => _loadingImages = false);
    }
  }

  Color get brandColor => Color(widget.brand.colorValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          // ── 이미지 슬라이더 앱바 ────────────────────────
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 1,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_back_ios_rounded,
                    color: Color(0xFF1A1A2E), size: 18),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.favorite_border_rounded,
                      color: Color(0xFF1A1A2E), size: 20),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImageSlider(),
            ),
          ),

          // ── 차량명 헤더 ──────────────────────────────
          SliverToBoxAdapter(child: _buildCarHeader()),

          // ── 탭 바 ────────────────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              TabBar(
                controller: _tabController,
                indicatorColor: brandColor,
                indicatorWeight: 3,
                labelColor: brandColor,
                unselectedLabelColor: const Color(0xFFBCC3CE),
                labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontSize: 13),
                tabs: const [Tab(text: "성능 스펙"), Tab(text: "외관/내관"), Tab(text: "가격 비교")],
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [_buildSpecTab(), _buildPhotoTab(), _buildPriceTab()],
        ),
      ),
    );
  }

  // ── 이미지 슬라이더 ───────────────────────────────────────
  Widget _buildImageSlider() {
    final all = [..._exteriorImages, ..._interiorImages];

    if (_loadingImages) {
      return Container(
        color: brandColor.withOpacity(0.05),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(color: brandColor, strokeWidth: 2.5),
          const SizedBox(height: 14),
          Text("이미지 불러오는 중...",
            style: TextStyle(color: brandColor, fontSize: 13)),
        ]),
      );
    }

    if (all.isEmpty) {
      return Container(
        color: brandColor.withOpacity(0.05),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.directions_car_rounded, color: brandColor.withOpacity(0.3), size: 72),
          const SizedBox(height: 12),
          Text(widget.model.name,
            style: TextStyle(color: brandColor, fontSize: 16, fontWeight: FontWeight.bold)),
        ]),
      );
    }

    return Stack(children: [
      PageView.builder(
        itemCount: all.length,
        onPageChanged: (i) => setState(() => _currentImageIndex = i),
        itemBuilder: (_, i) => Image.network(all[i], fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: brandColor.withOpacity(0.05),
            child: Icon(Icons.image_not_supported_rounded,
                color: brandColor.withOpacity(0.2), size: 48))),
      ),

      // 하단 그라데이션
      Positioned.fill(child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
            stops: const [0.55, 1.0],
          ),
        ),
      )),

      // 외관/내관 라벨 + 인디케이터
      Positioned(bottom: 14, left: 0, right: 0,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: _currentImageIndex < _exteriorImages.length
                  ? brandColor : Colors.black54,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _currentImageIndex < _exteriorImages.length ? "익스테리어" : "인테리어",
              style: const TextStyle(fontSize: 11, color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(all.length, (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: _currentImageIndex == i ? 18 : 5,
              height: 5,
              decoration: BoxDecoration(
                color: _currentImageIndex == i ? Colors.white : Colors.white38,
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
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: brandColor.withOpacity(0.10),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(widget.brand.name,
                style: TextStyle(fontSize: 11, color: brandColor,
                    fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 6),
            Text(widget.model.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E))),
            const SizedBox(height: 3),
            Text(widget.model.tagline,
              style: const TextStyle(fontSize: 13, color: Color(0xFF8A94A6))),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Text("시작가",
              style: TextStyle(fontSize: 11, color: Color(0xFF8A94A6))),
            const SizedBox(height: 2),
            Text(widget.model.price,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                  color: brandColor)),
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
          childAspectRatio: 1.85,
          children: [
            _specCard("최고 출력", "${m.hp}", "hp"),
            _specCard("0→100 km/h", "${m.z100}", "초"),
            _specCard("최대 토크", "${m.torque}", "kgf·m"),
            _specCard("최고 속도", "${m.topSpeed}", "km/h"),
          ],
        ),
        const SizedBox(height: 14),

        // 바 차트
        _buildBarChart(m),
        const SizedBox(height: 14),

        // 상세 정보 테이블
        _infoTable([
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
        _sectionTitle("익스테리어", Icons.directions_car_rounded),
        const SizedBox(height: 10),
        _loadingImages ? _loadingGrid() :
        _exteriorImages.isEmpty ? _emptyBox("이미지 없음") :
        _imageGrid(_exteriorImages),

        const SizedBox(height: 22),

        _sectionTitle("인테리어", Icons.airline_seat_recline_normal_rounded),
        const SizedBox(height: 10),
        _loadingImages ? _loadingGrid() :
        _interiorImages.isEmpty ? _emptyBox("이미지 없음") :
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
        _sectionTitle("트림별 가격", Icons.monetization_on_rounded),
        const SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE8ECF0)),
            boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 3))],
          ),
          child: Column(children: m.trims.asMap().entries.map((e) {
            final isFirst = e.key == 0;
            final isLast = e.key == m.trims.length - 1;
            return Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: isFirst ? brandColor.withOpacity(0.04) : Colors.transparent,
                  borderRadius: BorderRadius.vertical(
                    top: isFirst ? const Radius.circular(16) : Radius.zero,
                    bottom: isLast ? const Radius.circular(16) : Radius.zero,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [
                    if (isFirst) Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: brandColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text("기본",
                        style: TextStyle(fontSize: 9, color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    ),
                    Text(e.value.name,
                      style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E),
                          fontWeight: FontWeight.w500)),
                  ]),
                  Text(e.value.price,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                        color: brandColor)),
                ]),
              ),
              if (!isLast) const Divider(height: 1, color: Color(0xFFF0F2F5), indent: 18, endIndent: 18),
            ]);
          }).toList()),
        ),

        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: brandColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
          child: const Text("딜러 문의하기", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: brandColor,
            side: BorderSide(color: brandColor, width: 1.2),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8ECF0)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 6, offset: Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF8A94A6))),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(value, style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: brandColor)),
            const SizedBox(width: 3),
            Padding(padding: const EdgeInsets.only(bottom: 2),
              child: Text(unit,
                style: const TextStyle(fontSize: 11, color: Color(0xFF8A94A6)))),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECF0)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 3))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(children: bars.map((b) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(b.$1, style: const TextStyle(fontSize: 12, color: Color(0xFF5A6478))),
            Text(b.$2, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                color: brandColor)),
          ]),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: b.$3.clamp(0.0, 1.0),
              minHeight: 7,
              backgroundColor: const Color(0xFFF0F2F5),
              valueColor: AlwaysStoppedAnimation<Color>(brandColor),
            ),
          ),
        ]),
      )).toList()),
    );
  }

  Widget _infoTable(List<(String, String)> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECF0)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Column(children: items.asMap().entries.map((e) {
        final isLast = e.key == items.length - 1;
        return Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(e.value.$1, style: const TextStyle(fontSize: 13, color: Color(0xFF8A94A6))),
              Text(e.value.$2, style: const TextStyle(fontSize: 13,
                  fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
            ]),
          ),
          if (!isLast) const Divider(height: 1, color: Color(0xFFF4F6FA), indent: 18, endIndent: 18),
        ]);
      }).toList()),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: brandColor.withOpacity(0.10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: brandColor, size: 16),
      ),
      const SizedBox(width: 10),
      Text(title, style: const TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
    ]);
  }

  Widget _imageGrid(List<String> urls) {
    return GridView.builder(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 1.5),
      itemCount: urls.length,
      itemBuilder: (_, i) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(urls[i], fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: brandColor.withOpacity(0.05),
            child: Icon(Icons.image_not_supported_rounded,
              color: brandColor.withOpacity(0.2), size: 32))),
      ),
    );
  }

  Widget _loadingGrid() {
    return GridView.count(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 1.5,
      children: List.generate(4, (_) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: const Color(0xFFF0F2F5),
          child: Center(child: CircularProgressIndicator(color: brandColor, strokeWidth: 2)),
        ),
      )),
    );
  }

  Widget _emptyBox(String msg) => Container(
    height: 100,
    decoration: BoxDecoration(
      color: const Color(0xFFF8F9FB),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE8ECF0)),
    ),
    child: Center(child: Text(msg,
      style: const TextStyle(color: Color(0xFFBCC3CE), fontSize: 13))),
  );
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;
  const _TabBarDelegate(this.tabBar, {required this.backgroundColor});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEF0F4))),
      ),
      child: tabBar,
    );
  }
  @override double get minExtent => tabBar.preferredSize.height;
  @override double get maxExtent => tabBar.preferredSize.height;
  @override bool shouldRebuild(_TabBarDelegate old) => false;
}
