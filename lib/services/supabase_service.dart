// ============================================================
// lib/services/supabase_service.dart
// Supabase API 연동 서비스
// 브랜드/모델/트림 데이터를 서버에서 실시간으로 가져옴
// ============================================================

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/car_data.dart';

class SupabaseService {
  // ── Supabase 프로젝트 설정 ─────────────────────────────
  static const String _baseUrl =
      'https://exqgfrzpxrfuswwmkdey.supabase.co/rest/v1';
  static const String _apiKey =
      'sb_publishable_BoAIQuozAha__ue_UM8v2Q_XTExiavb';

  static const Map<String, String> _headers = {
    'apikey': _apiKey,
    'Authorization': 'Bearer $_apiKey',
    'Content-Type': 'application/json',
  };

  // 캐시 (한 번 로드 후 재사용)
  static List<CarBrand>? _cachedBrands;

  // ── 전체 브랜드 + 모델 + 트림 로드 ─────────────────────
  static Future<List<CarBrand>> fetchAllBrands() async {
    // 캐시 있으면 즉시 반환
    if (_cachedBrands != null) return _cachedBrands!;

    try {
      // 1. 브랜드 목록 가져오기
      final brandsRes = await http.get(
        Uri.parse('$_baseUrl/brands?order=id'),
        headers: _headers,
      ).timeout(const Duration(seconds: 10));

      if (brandsRes.statusCode != 200) throw Exception('브랜드 로드 실패');
      final brandsJson = jsonDecode(brandsRes.body) as List;

      // 2. 전체 모델 목록 가져오기
      final modelsRes = await http.get(
        Uri.parse('$_baseUrl/car_models?order=brand_id,id'),
        headers: _headers,
      ).timeout(const Duration(seconds: 10));

      if (modelsRes.statusCode != 200) throw Exception('모델 로드 실패');
      final modelsJson = jsonDecode(modelsRes.body) as List;

      // 3. 전체 트림 목록 가져오기
      final trimsRes = await http.get(
        Uri.parse('$_baseUrl/car_trims?order=model_id,id'),
        headers: _headers,
      ).timeout(const Duration(seconds: 10));

      if (trimsRes.statusCode != 200) throw Exception('트림 로드 실패');
      final trimsJson = jsonDecode(trimsRes.body) as List;

      // 4. 데이터 조립
      final brands = brandsJson.map((b) {
        final brandId = b['id'] as int;

        // 해당 브랜드의 모델 필터링
        final models = modelsJson
            .where((m) => m['brand_id'] == brandId)
            .map((m) {
              final modelId = m['id'] as int;

              // 해당 모델의 트림 필터링
              final trims = trimsJson
                  .where((t) => t['model_id'] == modelId)
                  .map((t) => CarTrim(
                        t['name'] as String,
                        t['price'] as String,
                      ))
                  .toList();

              // 트림이 없으면 기본 트림 생성
              if (trims.isEmpty) {
                trims.add(CarTrim(
                  m['name'] as String,
                  m['price'] as String,
                ));
              }

              return CarModel(
                name: m['name'] as String,
                price: m['price'] as String,
                tagline: m['tagline'] as String,
                hp: m['hp'] as int,
                torque: (m['torque'] as num).toDouble(),
                z100: (m['z100'] as num).toDouble(),
                topSpeed: m['top_speed'] as int,
                fuel: m['fuel'] as String,
                drive: m['drive'] as String,
                exteriorKeyword: m['exterior_keyword'] as String? ?? '',
                interiorKeyword: m['interior_keyword'] as String? ?? '',
                trims: trims,
              );
            })
            .toList();

        return CarBrand(
          name: b['name'] as String,
          colorValue: int.parse(
              'FF${(b['color_hex'] as String).replaceAll('#', '')}',
              radix: 16),
          models: models,
        );
      }).toList();

      _cachedBrands = brands;
      return brands;
    } catch (e) {
      print('[SupabaseService] 오류: $e');
      // 오류 시 기존 하드코딩 데이터 반환
      return carBrands;
    }
  }

  /// 캐시 초기화 (새로고침용)
  static void clearCache() => _cachedBrands = null;
}
