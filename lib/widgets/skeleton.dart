// ============================================================
// lib/widgets/skeleton.dart
// 스켈레톤 로딩 UI - shimmer 애니메이션 효과
// 이미지/카드/리스트 로딩 중 표시
// ============================================================

import 'package:flutter/material.dart';

// ── Shimmer 애니메이션 베이스 ──────────────────────────────
class SkeletonBox extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _anim = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: LinearGradient(
            begin: Alignment(_anim.value - 1, 0),
            end: Alignment(_anim.value + 1, 0),
            colors: const [
              Color(0xFFEEF0F4),
              Color(0xFFF8F9FB),
              Color(0xFFEEF0F4),
            ],
          ),
        ),
      ),
    );
  }
}

// ── 모델 카드 스켈레톤 ────────────────────────────────────
class ModelCardSkeleton extends StatelessWidget {
  const ModelCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8ECF0)),
        boxShadow: const [
          BoxShadow(color: Color(0x0C000000), blurRadius: 10,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(children: [
        // 이미지 영역
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          child: SkeletonBox(
              width: double.infinity, height: 190, borderRadius: 0)),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(children: [
            // 스펙 바
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(4, (i) => Column(children: [
                  SkeletonBox(width: 40, height: 14, borderRadius: 4),
                  const SizedBox(height: 4),
                  SkeletonBox(width: 28, height: 10, borderRadius: 4),
                ])),
              ),
            ),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SkeletonBox(width: 100, height: 12, borderRadius: 4),
              SkeletonBox(width: 72, height: 28, borderRadius: 20),
            ]),
          ]),
        ),
      ]),
    );
  }
}

// ── 브랜드 카드 스켈레톤 ─────────────────────────────────
class BrandCardSkeleton extends StatelessWidget {
  const BrandCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8ECF0)),
        boxShadow: const [
          BoxShadow(color: Color(0x0C000000), blurRadius: 10,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(children: [
        // 상단 컬러 바
        Container(height: 5,
          decoration: const BoxDecoration(
            color: Color(0xFFEEF0F4),
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)))),
        Expanded(child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                SkeletonBox(width: 28, height: 28, borderRadius: 14),
                const SizedBox(width: 8),
                SkeletonBox(width: 70, height: 16, borderRadius: 4),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SkeletonBox(width: 60, height: 22, borderRadius: 11),
                SkeletonBox(width: 24, height: 24, borderRadius: 12),
              ]),
            ],
          ),
        )),
      ]),
    );
  }
}

// ── 이미지 그리드 스켈레톤 ───────────────────────────────
class ImageGridSkeleton extends StatelessWidget {
  final int count;
  const ImageGridSkeleton({super.key, this.count = 4});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.5,
      children: List.generate(count, (_) =>
        SkeletonBox(width: double.infinity, height: double.infinity,
            borderRadius: 12)),
    );
  }
}

// ── 상세 스펙 카드 스켈레톤 ──────────────────────────────
class SpecCardSkeleton extends StatelessWidget {
  const SpecCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SkeletonBox(width: 60, height: 11, borderRadius: 4),
          SkeletonBox(width: 80, height: 22, borderRadius: 4),
        ],
      ),
    );
  }
}

// ── 검색 결과 아이템 스켈레톤 ────────────────────────────
class SearchResultSkeleton extends StatelessWidget {
  const SearchResultSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Column(children: [
        Container(height: 4,
          decoration: const BoxDecoration(
            color: Color(0xFFEEF0F4),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)))),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: 50, height: 11, borderRadius: 4),
                const SizedBox(height: 5),
                SkeletonBox(width: 130, height: 15, borderRadius: 4),
                const SizedBox(height: 5),
                SkeletonBox(width: 100, height: 12, borderRadius: 4),
                const SizedBox(height: 10),
                Row(children: [
                  SkeletonBox(width: 60, height: 22, borderRadius: 6),
                  const SizedBox(width: 6),
                  SkeletonBox(width: 50, height: 22, borderRadius: 6),
                  const SizedBox(width: 6),
                  SkeletonBox(width: 55, height: 22, borderRadius: 6),
                ]),
              ],
            )),
            const SizedBox(width: 10),
            Column(children: [
              SkeletonBox(width: 70, height: 13, borderRadius: 4),
              const SizedBox(height: 8),
              SkeletonBox(width: 14, height: 14, borderRadius: 4),
            ]),
          ]),
        ),
      ]),
    );
  }
}

// ── 즐겨찾기 아이템 스켈레톤 ────────────────────────────
class FavoriteItemSkeleton extends StatelessWidget {
  const FavoriteItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Row(children: [
        SkeletonBox(width: 4, height: 56, borderRadius: 2),
        const SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(width: 50, height: 11, borderRadius: 4),
            const SizedBox(height: 5),
            SkeletonBox(width: 120, height: 15, borderRadius: 4),
            const SizedBox(height: 5),
            SkeletonBox(width: 90, height: 12, borderRadius: 4),
          ],
        )),
        Column(children: [
          SkeletonBox(width: 70, height: 13, borderRadius: 4),
          const SizedBox(height: 8),
          SkeletonBox(width: 14, height: 14, borderRadius: 4),
        ]),
      ]),
    );
  }
}

// ── 이미지 슬라이더 스켈레톤 ─────────────────────────────
class ImageSliderSkeleton extends StatelessWidget {
  final double height;
  const ImageSliderSkeleton({super.key, this.height = 280});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SkeletonBox(width: double.infinity, height: height, borderRadius: 0),
      // 로딩 인디케이터 + 텍스트
      Positioned.fill(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _PulsingCarIcon(),
          const SizedBox(height: 16),
          const Text("이미지 불러오는 중...",
            style: TextStyle(fontSize: 13, color: Color(0xFF8A94A6),
                fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          const SizedBox(
            width: 120,
            child: LinearProgressIndicator(
              backgroundColor: Color(0xFFE8ECF0),
              valueColor: AlwaysStoppedAnimation(Color(0xFF378ADD)),
              minHeight: 3,
            ),
          ),
        ],
      )),
    ]);
  }
}

// ── 자동차 아이콘 펄싱 애니메이션 ───────────────────────
class _PulsingCarIcon extends StatefulWidget {
  const _PulsingCarIcon();

  @override
  State<_PulsingCarIcon> createState() => _PulsingCarIconState();
}

class _PulsingCarIconState extends State<_PulsingCarIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.85, end: 1.1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: const Icon(Icons.directions_car_rounded,
          size: 52, color: Color(0xFFBCC3CE)),
    );
  }
}

// ── 전체 페이지 로딩 오버레이 ────────────────────────────
class LoadingOverlay extends StatelessWidget {
  final String message;
  const LoadingOverlay({super.key, this.message = "로딩 중..."});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.85),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _PulsingCarIcon(),
          const SizedBox(height: 16),
          Text(message,
            style: const TextStyle(fontSize: 14, color: Color(0xFF5A6478),
                fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          const SizedBox(width: 140,
            child: LinearProgressIndicator(
              backgroundColor: Color(0xFFE8ECF0),
              valueColor: AlwaysStoppedAnimation(Color(0xFF378ADD)),
              minHeight: 3,
            )),
        ],
      )),
    );
  }
}
