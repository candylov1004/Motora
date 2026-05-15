// ============================================================
// lib/widgets/image_viewer.dart
// 전체화면 이미지 뷰어 - 핀치 줌 + 좌우 스와이프
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreenImageViewer extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final String title;

  const FullScreenImageViewer({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
    this.title = "",
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageCtrl;
  late int _currentIndex;
  bool _showUI = true; // UI 오버레이 표시 여부

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageCtrl = PageController(initialPage: widget.initialIndex);

    // 전체화면 몰입 모드
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    // 시스템 UI 복원
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _toggleUI() => setState(() => _showUI = !_showUI);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [

        // ── 이미지 페이지뷰 ────────────────────────────────
        PageView.builder(
          controller: _pageCtrl,
          itemCount: widget.imageUrls.length,
          onPageChanged: (i) => setState(() => _currentIndex = i),
          itemBuilder: (_, i) => GestureDetector(
            onTap: _toggleUI,
            child: Center(
              child: InteractiveViewer(
                // 핀치 줌 활성화
                minScale: 0.8,
                maxScale: 5.0,
                child: Image.network(
                  widget.imageUrls[i],
                  fit: BoxFit.contain,
                  loadingBuilder: (_, child, progress) =>
                    progress == null ? child : Center(
                      child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!
                          : null,
                        color: Colors.white54,
                        strokeWidth: 2,
                      )),
                  errorBuilder: (_, __, ___) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.broken_image_rounded,
                          color: Colors.white24, size: 64),
                      SizedBox(height: 12),
                      Text("이미지를 불러올 수 없습니다",
                          style: TextStyle(color: Colors.white38, fontSize: 13)),
                    ]),
                ),
              ),
            ),
          ),
        ),

        // ── 상단 오버레이 (뒤로가기 + 제목 + 카운터) ──────
        AnimatedOpacity(
          opacity: _showUI ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black87, Colors.transparent],
                stops: [0.0, 1.0],
              ),
            ),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 8, right: 16, bottom: 20),
            child: Row(children: [
              // 뒤로가기
              IconButton(
                icon: const Icon(Icons.close_rounded,
                    color: Colors.white, size: 26),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 4),
              // 제목
              Expanded(child: Text(widget.title,
                style: const TextStyle(
                    color: Colors.white, fontSize: 15,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis)),
              // 이미지 카운터
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "${_currentIndex + 1} / ${widget.imageUrls.length}",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 13,
                      fontWeight: FontWeight.w500)),
              ),
            ]),
          ),
        ),

        // ── 하단 오버레이 (썸네일 + 인디케이터) ──────────
        AnimatedOpacity(
          opacity: _showUI ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 12,
                top: 20),
              child: Column(children: [
                // 인디케이터 도트
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.imageUrls.length, (i) =>
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentIndex == i ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _currentIndex == i
                            ? Colors.white : Colors.white38,
                        borderRadius: BorderRadius.circular(3)),
                    )),
                ),
                const SizedBox(height: 12),

                // 썸네일 스크롤
                if (widget.imageUrls.length > 1)
                  SizedBox(
                    height: 56,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: widget.imageUrls.length,
                      itemBuilder: (_, i) => GestureDetector(
                        onTap: () {
                          _pageCtrl.animateToPage(i,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 8),
                          width: 56, height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _currentIndex == i
                                ? Colors.white : Colors.transparent,
                              width: 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.network(
                              widget.imageUrls[i], fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.white12,
                                child: const Icon(Icons.image_rounded,
                                    color: Colors.white24, size: 24))),
                          ),
                        ),
                      ),
                    ),
                  ),
              ]),
            ),
          ),
        ),

        // ── 좌우 이동 화살표 ──────────────────────────────
        if (_showUI && widget.imageUrls.length > 1) ...[
          // 이전
          Positioned(left: 8, top: 0, bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => _currentIndex > 0
                  ? _pageCtrl.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut)
                  : null,
                child: AnimatedOpacity(
                  opacity: _currentIndex > 0 ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle),
                    child: const Icon(Icons.chevron_left_rounded,
                        color: Colors.white, size: 28)),
                ),
              ),
            ),
          ),
          // 다음
          Positioned(right: 8, top: 0, bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => _currentIndex < widget.imageUrls.length - 1
                  ? _pageCtrl.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut)
                  : null,
                child: AnimatedOpacity(
                  opacity: _currentIndex < widget.imageUrls.length - 1
                      ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle),
                    child: const Icon(Icons.chevron_right_rounded,
                        color: Colors.white, size: 28)),
                ),
              ),
            ),
          ),
        ],
      ]),
    );
  }
}
