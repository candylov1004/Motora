// ============================================================
// lib/screens/favorites_screen.dart
// 즐겨찾기 화면
// ============================================================

import 'package:flutter/material.dart';
import '../models/car_data.dart';
import '../services/storage_service.dart';
import '../widgets/skeleton.dart';
import 'car_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, String>> _favorites = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final favs = await StorageService.getFavorites();
    if (mounted) setState(() { _favorites = favs; _loading = false; });
  }

  Future<void> _remove(int i) async {
    final fav = _favorites[i];
    await StorageService.removeFavorite(fav['brand']!, fav['model']!);
    setState(() => _favorites.removeAt(i));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${fav['model']} 즐겨찾기 해제"),
        action: SnackBarAction(label: "취소", onPressed: () async {
          await StorageService.addFavorite(fav['brand']!, fav['model']!);
          _load();
        })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("즐겨찾기",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E))),
        actions: [
          if (_favorites.isNotEmpty)
            TextButton(
              onPressed: () async {
                final confirm = await showDialog<bool>(context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("즐겨찾기 전체 삭제"),
                    content: const Text("모든 즐겨찾기를 삭제할까요?"),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, false),
                        child: const Text("취소")),
                      TextButton(onPressed: () => Navigator.pop(context, true),
                        child: const Text("삭제", style: TextStyle(color: Colors.red))),
                    ],
                  ));
                if (confirm == true) {
                  for (final f in _favorites) {
                    await StorageService.removeFavorite(f['brand']!, f['model']!);
                  }
                  _load();
                }
              },
              child: const Text("전체삭제",
                style: TextStyle(color: Colors.red, fontSize: 13)),
            ),
        ],
      ),
      body: _loading
        ? ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 5,
          itemBuilder: (_, __) => const FavoriteItemSkeleton())
        : _favorites.isEmpty
          ? _buildEmpty()
          : _buildList(),
    );
  }

  Widget _buildEmpty() => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.favorite_border_rounded, size: 72,
          color: Colors.grey.withOpacity(0.3)),
      const SizedBox(height: 16),
      const Text("즐겨찾기한 차량이 없어요",
        style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6))),
      const SizedBox(height: 8),
      const Text("차량 상세 화면에서 ♥를 눌러 추가하세요",
        style: TextStyle(fontSize: 13, color: Color(0xFFBCC3CE))),
    ]),
  );

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _favorites.length,
      itemBuilder: (context, i) {
        final fav = _favorites[i];
        final brand = carBrands.firstWhere(
          (b) => b.name == fav['brand'],
          orElse: () => carBrands.first);
        final model = brand.models.firstWhere(
          (m) => m.name == fav['model'],
          orElse: () => brand.models.first);
        final color = Color(brand.colorValue);

        return Dismissible(
          key: Key('${fav['brand']}_${fav['model']}'),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => _remove(i),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.delete_rounded, color: Colors.white)),
          child: GestureDetector(
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) =>
                CarDetailScreen(brand: brand, model: model))),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8ECF0)),
                boxShadow: const [BoxShadow(color: Color(0x08000000),
                    blurRadius: 8, offset: Offset(0, 3))]),
              child: Row(children: [
                // 브랜드 색상 바
                Container(width: 4, height: 56,
                  decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: 12),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fav['brand']!,
                      style: TextStyle(fontSize: 11, color: color,
                          fontWeight: FontWeight.w600)),
                    Text(fav['model']!,
                      style: const TextStyle(fontSize: 15,
                          fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
                    Text(model.tagline,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF8A94A6))),
                  ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(model.price,
                    style: TextStyle(fontSize: 13,
                        fontWeight: FontWeight.bold, color: color)),
                  const SizedBox(height: 4),
                  Icon(Icons.arrow_forward_ios_rounded,
                      size: 14, color: Colors.grey.shade300),
                ]),
              ]),
            ),
          ),
        );
      },
    );
  }
}
