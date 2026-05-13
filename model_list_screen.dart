// ============================================================
// lib/services/unsplash_service.dart
// Unsplash API 연동 - 차량 이미지 검색
// API 키: https://unsplash.com/developers 에서 무료 발급
// ============================================================

import 'dart:convert';
import 'package:http/http.dart' as http;

class UnsplashService {
  // ⚠️ 아래 키를 본인의 Unsplash Access Key로 교체하세요
  // https://unsplash.com/developers → New Application → Access Key 복사
  static const String _accessKey = 'YOUR_UNSPLASH_ACCESS_KEY';
  static const String _baseUrl = 'https://api.unsplash.com';

  // 이미지 URL 캐시 (같은 검색어 중복 요청 방지)
  static final Map<String, List<String>> _cache = {};

  /// 키워드로 Unsplash 이미지 검색 후 URL 목록 반환
  static Future<List<String>> searchImages(String query, {int count = 4}) async {
    // 캐시 확인
    if (_cache.containsKey(query)) return _cache[query]!;

    try {
      final uri = Uri.parse('$_baseUrl/search/photos').replace(
        queryParameters: {
          'query': query,
          'per_page': count.toString(),
          'orientation': 'landscape',
          'content_filter': 'high',
        },
      );

      final response = await http.get(uri, headers: {
        'Authorization': 'Client-ID $_accessKey',
      }).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List;

        final urls = results
            .map((r) => r['urls']['regular'] as String)
            .toList();

        _cache[query] = urls; // 캐시 저장
        return urls;
      }
    } catch (e) {
      // 네트워크 오류 시 빈 목록 반환 (플레이스홀더 표시)
      debugPrint('Unsplash API error: $e');
    }
    return [];
  }
}

// Flutter debug print import
void debugPrint(String message) {
  // ignore: avoid_print
  print('[MOTORA] $message');
}
