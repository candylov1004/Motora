// ============================================================
// lib/services/storage_service.dart
// 즐겨찾기 + 내 차 등록 로컬 저장 서비스
// shared_preferences 패키지 사용
// ============================================================

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _favKey = 'favorites';
  static const _myCarKey = 'my_cars';

  // ── 즐겨찾기 ─────────────────────────────────────────────

  /// 즐겨찾기 목록 불러오기
  static Future<List<Map<String, String>>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_favKey) ?? [];
    return raw.map((e) => Map<String, String>.from(jsonDecode(e))).toList();
  }

  /// 즐겨찾기 추가
  static Future<void> addFavorite(String brand, String model) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_favKey) ?? [];
    final item = jsonEncode({'brand': brand, 'model': model});
    if (!list.contains(item)) {
      list.add(item);
      await prefs.setStringList(_favKey, list);
    }
  }

  /// 즐겨찾기 제거
  static Future<void> removeFavorite(String brand, String model) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_favKey) ?? [];
    final item = jsonEncode({'brand': brand, 'model': model});
    list.remove(item);
    await prefs.setStringList(_favKey, list);
  }

  /// 즐겨찾기 여부 확인
  static Future<bool> isFavorite(String brand, String model) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_favKey) ?? [];
    final item = jsonEncode({'brand': brand, 'model': model});
    return list.contains(item);
  }

  // ── 내 차 ─────────────────────────────────────────────────

  /// 내 차 목록 불러오기
  static Future<List<MyCar>> getMyCars() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_myCarKey) ?? [];
    return raw.map((e) => MyCar.fromJson(jsonDecode(e))).toList();
  }

  /// 내 차 등록
  static Future<void> addMyCar(MyCar car) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_myCarKey) ?? [];
    list.add(jsonEncode(car.toJson()));
    await prefs.setStringList(_myCarKey, list);
  }

  /// 내 차 삭제
  static Future<void> removeMyCar(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_myCarKey) ?? [];
    if (index >= 0 && index < list.length) {
      list.removeAt(index);
      await prefs.setStringList(_myCarKey, list);
    }
  }
}

/// 내 차 데이터 모델
class MyCar {
  final String brand;
  final String model;
  final int year;
  final String trim;
  final String color;
  final String memo;
  final DateTime registeredAt;

  MyCar({
    required this.brand,
    required this.model,
    required this.year,
    required this.trim,
    required this.color,
    this.memo = '',
    DateTime? registeredAt,
  }) : registeredAt = registeredAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'brand': brand,
    'model': model,
    'year': year,
    'trim': trim,
    'color': color,
    'memo': memo,
    'registeredAt': registeredAt.toIso8601String(),
  };

  factory MyCar.fromJson(Map<String, dynamic> json) => MyCar(
    brand: json['brand'],
    model: json['model'],
    year: json['year'],
    trim: json['trim'],
    color: json['color'],
    memo: json['memo'] ?? '',
    registeredAt: DateTime.parse(json['registeredAt']),
  );
}
