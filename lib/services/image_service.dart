// ============================================================
// lib/services/image_service.dart
// Wikimedia Commons API 자동 검색 - API 키 불필요
// ============================================================

import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageService {
  static final Map<String, List<String>> _cache = {};

  static Future<List<String>> fetchCarImages(String query,
      {int count = 4, String? fallbackQuery}) async {
    final key = '$query-$count';
    if (_cache.containsKey(key)) return _cache[key]!;

    var urls = await _searchWikimedia(query, count);
    if (urls.isEmpty && fallbackQuery != null) {
      urls = await _searchWikimedia(fallbackQuery, count);
    }
    if (urls.isEmpty) {
      urls = await _searchWikimedia(query.split(' ').take(2).join(' '), count);
    }

    _cache[key] = urls;
    return urls;
  }

  static Future<List<String>> fetchInteriorImages(String query,
      {int count = 4}) async {
    return fetchCarImages('$query interior', count: count,
        fallbackQuery: '$query cockpit dashboard');
  }

  static Future<List<String>> _searchWikimedia(String query, int count) async {
    try {
      final searchUri =
          Uri.parse('https://commons.wikimedia.org/w/api.php').replace(
        queryParameters: {
          'action': 'query',
          'list': 'search',
          'srsearch': query,
          'srnamespace': '6',
          'srlimit': (count * 4).toString(),
          'format': 'json',
          'origin': '*',
        },
      );

      final searchResp =
          await http.get(searchUri).timeout(const Duration(seconds: 10));
      if (searchResp.statusCode != 200) return [];

      final searchData = jsonDecode(searchResp.body);
      final results = searchData['query']?['search'] as List?;
      if (results == null || results.isEmpty) return [];

      final titles = results
          .map((r) => r['title'] as String)
          .where(_isValidCarImage)
          .take(count)
          .toList();

      if (titles.isEmpty) return [];

      final infoUri =
          Uri.parse('https://commons.wikimedia.org/w/api.php').replace(
        queryParameters: {
          'action': 'query',
          'titles': titles.join('|'),
          'prop': 'imageinfo',
          'iiprop': 'url',
          'iiurlwidth': '800',
          'format': 'json',
          'origin': '*',
        },
      );

      final infoResp =
          await http.get(infoUri).timeout(const Duration(seconds: 10));
      if (infoResp.statusCode != 200) return [];

      final infoData = jsonDecode(infoResp.body);
      final pages =
          infoData['query']?['pages'] as Map<String, dynamic>?;
      if (pages == null) return [];

      return pages.values
          .map((p) => p['imageinfo']?[0]?['thumburl'] as String?)
          .where((u) => u != null && u.isNotEmpty)
          .cast<String>()
          .toList();
    } catch (e) {
      print('[ImageService] $e');
      return [];
    }
  }

  static bool _isValidCarImage(String title) {
    final l = title.toLowerCase();
    const bad = [
      'logo', 'badge', 'emblem', 'icon', 'map', 'diagram',
      'brochure', 'police', 'taxi', 'ambulance', 'fire', 'race',
      'wikipedia', 'svg'
    ];
    for (final b in bad) {
      if (l.contains(b)) return false;
    }
    return l.endsWith('.jpg') || l.endsWith('.jpeg') || l.endsWith('.png');
  }
}
