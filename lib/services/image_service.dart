// ============================================================
// lib/services/image_service.dart
// Wikimedia Commons API + 백업 이미지 서비스
// API 키 불필요 - 완전 무료
// ============================================================

import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageService {
  // 이미지 URL 캐시
  static final Map<String, List<String>> _cache = {};

  /// 차량 모델명으로 Wikimedia Commons에서 이미지 검색
  static Future<List<String>> fetchCarImages(String query, {int count = 4}) async {
    if (_cache.containsKey(query)) return _cache[query]!;

    try {
      // Wikimedia Commons API 검색
      final uri = Uri.parse(
        'https://en.wikipedia.org/w/api.php'
      ).replace(queryParameters: {
        'action': 'query',
        'generator': 'search',
        'gsrsearch': query,
        'gsrnamespace': '6', // File 네임스페이스 (이미지)
        'gsrlimit': count.toString(),
        'prop': 'imageinfo',
        'iiprop': 'url',
        'iiurlwidth': '800',
        'format': 'json',
        'origin': '*',
      });

      final response = await http.get(uri).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final pages = data['query']?['pages'] as Map<String, dynamic>?;

        if (pages != null) {
          final urls = pages.values
              .map((p) => p['imageinfo']?[0]?['thumburl'] as String?)
              .where((url) => url != null && url.isNotEmpty)
              .cast<String>()
              .toList();

          if (urls.isNotEmpty) {
            _cache[query] = urls;
            return urls;
          }
        }
      }
    } catch (e) {
      print('[ImageService] Wikimedia error: $e');
    }

    // 백업: 차량 모델명 기반 고정 이미지 URL 반환
    final fallback = _getFallbackImages(query);
    _cache[query] = fallback;
    return fallback;
  }

  /// 모델명 키워드로 백업 이미지 URL 매핑
  /// (Wikimedia Commons 직접 URL - 실제 차량 사진)
  static List<String> _getFallbackImages(String query) {
    final q = query.toLowerCase();

    // ── 현대 ──────────────────────────────────────────────
    if (q.contains('ioniq 6') || q.contains('ioniq6')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/2023_Hyundai_IONIQ_6%2C_front_8.28.22.jpg/800px-2023_Hyundai_IONIQ_6%2C_front_8.28.22.jpg'];
    }
    if (q.contains('ioniq 5')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/2022_Hyundai_Ioniq_5%2C_front_9.6.21.jpg/800px-2022_Hyundai_Ioniq_5%2C_front_9.6.21.jpg'];
    }
    if (q.contains('tucson')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/2022_Hyundai_Tucson_%28NX4%29_Elite_2.0_Front.jpg/800px-2022_Hyundai_Tucson_%28NX4%29_Elite_2.0_Front.jpg'];
    }

    // ── 기아 ──────────────────────────────────────────────
    if (q.contains('ev6')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/2022_Kia_EV6_GT-Line_AWD%2C_front_8.15.21.jpg/800px-2022_Kia_EV6_GT-Line_AWD%2C_front_8.15.21.jpg'];
    }
    if (q.contains('stinger')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/2018_Kia_Stinger_GT_2.0T%2C_front_5.24.18.jpg/800px-2018_Kia_Stinger_GT_2.0T%2C_front_5.24.18.jpg'];
    }
    if (q.contains('sportage')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/2022_Kia_Sportage_HEV_GT-Line_S_2.0_Front.jpg/800px-2022_Kia_Sportage_HEV_GT-Line_S_2.0_Front.jpg'];
    }

    // ── BMW ───────────────────────────────────────────────
    if (q.contains('m4')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/2021_BMW_M4_Competition_%28G82%29%2C_front_8.28.21.jpg/800px-2021_BMW_M4_Competition_%28G82%29%2C_front_8.28.21.jpg'];
    }
    if (q.contains('m3')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/2021_BMW_M3_Competition_%28G80%29%2C_front_9.19.21.jpg/800px-2021_BMW_M3_Competition_%28G80%29%2C_front_9.19.21.jpg'];
    }
    if (q.contains('3 series') || q.contains('320') || q.contains('330')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/2019_BMW_330i_%28G20%29_Sport_2.0_Front.jpg/800px-2019_BMW_330i_%28G20%29_Sport_2.0_Front.jpg'];
    }
    if (q.contains('x5')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/2019_BMW_X5_xDrive30d_M_Sport_%28G05%29%2C_front_9.23.19.jpg/800px-2019_BMW_X5_xDrive30d_M_Sport_%28G05%29%2C_front_9.23.19.jpg'];
    }

    // ── Mercedes ──────────────────────────────────────────
    if (q.contains('amg c63') || q.contains('c63')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/2022_Mercedes-AMG_C_63_S_E_Performance_%28W206%29%2C_front.jpg/800px-2022_Mercedes-AMG_C_63_S_E_Performance_%28W206%29%2C_front.jpg'];
    }
    if (q.contains('e-class') || q.contains('e class') || q.contains('e200') || q.contains('e220')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/2021_Mercedes-Benz_E_220_d_%28W213%2C_facelift%29%2C_front_9.15.21.jpg/800px-2021_Mercedes-Benz_E_220_d_%28W213%2C_facelift%29%2C_front_9.15.21.jpg'];
    }
    if (q.contains('gle')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/2020_Mercedes-Benz_GLE_350_4Matic_%28V167%29%2C_front_9.7.20.jpg/800px-2020_Mercedes-Benz_GLE_350_4Matic_%28V167%29%2C_front_9.7.20.jpg'];
    }

    // ── Porsche ───────────────────────────────────────────
    if (q.contains('911 gt3')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/2022_Porsche_911_GT3_%28992%29%2C_front_4.3.22.jpg/800px-2022_Porsche_911_GT3_%28992%29%2C_front_4.3.22.jpg'];
    }
    if (q.contains('taycan')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/2020_Porsche_Taycan_4S%2C_front_10.28.19.jpg/800px-2020_Porsche_Taycan_4S%2C_front_10.28.19.jpg'];
    }
    if (q.contains('cayenne')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/2019_Porsche_Cayenne_S_%28facelift%2C_blue%29%2C_front_8.31.19.jpg/800px-2019_Porsche_Cayenne_S_%28facelift%2C_blue%29%2C_front_8.31.19.jpg'];
    }

    // ── Tesla ─────────────────────────────────────────────
    if (q.contains('model s')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/2020_Tesla_Model_S_Plaid%2C_front_10.3.21.jpg/800px-2020_Tesla_Model_S_Plaid%2C_front_10.3.21.jpg'];
    }
    if (q.contains('model 3')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/2019_Tesla_Model_3_Performance_AWD%2C_front_7.31.19.jpg/800px-2019_Tesla_Model_3_Performance_AWD%2C_front_7.31.19.jpg'];
    }
    if (q.contains('model y')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/2020_Tesla_Model_Y%2C_front_10.13.20.jpg/800px-2020_Tesla_Model_Y%2C_front_10.13.20.jpg'];
    }
    if (q.contains('cybertruck')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Tesla_Cybertruck%2C_front_12.31.19.jpg/800px-Tesla_Cybertruck%2C_front_12.31.19.jpg'];
    }

    // ── Toyota ────────────────────────────────────────────
    if (q.contains('gr86') || q.contains('gr 86')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/2022_Toyota_GR86%2C_front_4.11.22.jpg/800px-2022_Toyota_GR86%2C_front_4.11.22.jpg'];
    }
    if (q.contains('supra')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/2020_Toyota_GR_Supra_3.0%2C_front_5.21.20.jpg/800px-2020_Toyota_GR_Supra_3.0%2C_front_5.21.20.jpg'];
    }
    if (q.contains('rav4')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/2019_Toyota_RAV4_XLE_Premium_%28facelift%2C_red%29%2C_front_10.3.19.jpg/800px-2019_Toyota_RAV4_XLE_Premium_%28facelift%2C_red%29%2C_front_10.3.19.jpg'];
    }

    // ── Audi ──────────────────────────────────────────────
    if (q.contains('rs6')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/2022_Audi_RS_6_Avant_%28C8%29%2C_front_9.5.21.jpg/800px-2022_Audi_RS_6_Avant_%28C8%29%2C_front_9.5.21.jpg'];
    }
    if (q.contains('r8')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/2020_Audi_R8_V10_RWD_%28facelift%29%2C_front_9.13.20.jpg/800px-2020_Audi_R8_V10_RWD_%28facelift%29%2C_front_9.13.20.jpg'];
    }
    if (q.contains('e-tron gt') || q.contains('etron gt')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/2022_Audi_e-tron_GT%2C_front_9.5.21.jpg/800px-2022_Audi_e-tron_GT%2C_front_9.5.21.jpg'];
    }

    // ── Ferrari ───────────────────────────────────────────
    if (q.contains('sf90')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Ferrari_SF90_Stradale_-_Flickr_-_Alexandre_Prec%C3%AAncia_%281%29.jpg/800px-Ferrari_SF90_Stradale_-_Flickr_-_Alexandre_Prec%C3%AAncia_%281%29.jpg'];
    }
    if (q.contains('296')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Ferrari_296_GTB_%282022%29_%2851738680888%29.jpg/800px-Ferrari_296_GTB_%282022%29_%2851738680888%29.jpg'];
    }
    if (q.contains('roma')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Ferrari_Roma_%28cropped%29.jpg/800px-Ferrari_Roma_%28cropped%29.jpg'];
    }

    // ── Lamborghini ───────────────────────────────────────
    if (q.contains('huracan') || q.contains('huracán')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Lamborghini_Huracan_EVO_%2848681684407%29.jpg/800px-Lamborghini_Huracan_EVO_%2848681684407%29.jpg'];
    }
    if (q.contains('urus')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Lamborghini-Urus-LA-Auto-Show-2017.jpg/800px-Lamborghini-Urus-LA-Auto-Show-2017.jpg'];
    }
    if (q.contains('revuelto')) {
      return ['https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Lamborghini_Revuelto_%282023%29_-_front.jpg/800px-Lamborghini_Revuelto_%282023%29_-_front.jpg'];
    }

    // ── 기본 차량 이미지 (매칭 안될 때) ──────────────────
    return [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/No_image_available_450_x_300.svg/800px-No_image_available_450_x_300.svg.png',
    ];
  }
}
