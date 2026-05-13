// ============================================================
// lib/main.dart
// MOTORA 자동차 탐색 앱 - Flutter (Android/iOS)
// 16개 브랜드 · 48개 모델 · 성능 스펙 · 외관/내관 · 가격 비교
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 상태바 색상을 다크 테마에 맞게 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0C1B2E),
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MotoraApp());
}

// ── 앱 루트 ────────────────────────────────────────────────
class MotoraApp extends StatelessWidget {
  const MotoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOTORA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF378ADD),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0C1B2E),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// ── 데이터 모델 ────────────────────────────────────────────
class CarTrim {
  final String name;
  final String price;
  const CarTrim(this.name, this.price);
}

class CarModel {
  final String name;
  final String price;
  final String tagline;
  final int hp;
  final double torque;
  final double z100;
  final int topSpeed;
  final String fuel;
  final String drive;
  final List<CarTrim> trims;

  const CarModel({
    required this.name, required this.price, required this.tagline,
    required this.hp, required this.torque, required this.z100,
    required this.topSpeed, required this.fuel, required this.drive,
    required this.trims,
  });
}

class CarBrand {
  final String name;
  final Color color;
  final List<CarModel> models;
  const CarBrand({required this.name, required this.color, required this.models});
}

// ── 전체 데이터 ────────────────────────────────────────────
final List<CarBrand> carBrands = [
  CarBrand(name: "현대", color: const Color(0xFFE24B4A), models: [
    CarModel(name:"Sonata N Line", price:"₩5,290만~", tagline:"스포티 세단의 정수", hp:290, torque:40, z100:5.1, topSpeed:250, fuel:"가솔린 터보", drive:"FWD", trims:[CarTrim("N Line 스탠다드","5,290만원"),CarTrim("N Line 프리미엄","5,890만원"),CarTrim("N Line 퍼포먼스","6,290만원")]),
    CarModel(name:"IONIQ 6", price:"₩5,200만~", tagline:"전기차 혁신의 아이콘", hp:320, torque:61, z100:5.1, topSpeed:185, fuel:"순수 전기", drive:"RWD/AWD", trims:[CarTrim("스탠다드","5,200만원"),CarTrim("롱레인지 2WD","5,800만원"),CarTrim("롱레인지 AWD","6,300만원")]),
    CarModel(name:"Tucson", price:"₩3,099만~", tagline:"도심형 SUV 강자", hp:180, torque:27, z100:8.5, topSpeed:195, fuel:"가솔린/하이브리드", drive:"AWD", trims:[CarTrim("모던","3,099만원"),CarTrim("프리미엄","3,590만원"),CarTrim("인스퍼레이션","3,990만원")]),
  ]),
  CarBrand(name: "기아", color: const Color(0xFF185FA5), models: [
    CarModel(name:"EV6 GT", price:"₩7,490만~", tagline:"달리는 예술", hp:585, torque:74, z100:3.5, topSpeed:260, fuel:"순수 전기", drive:"AWD", trims:[CarTrim("GT 스탠다드","7,490만원"),CarTrim("GT 풀옵션","8,290만원")]),
    CarModel(name:"Stinger", price:"₩4,890만~", tagline:"그란투리스모의 감동", hp:370, torque:52, z100:4.9, topSpeed:270, fuel:"가솔린 터보", drive:"RWD", trims:[CarTrim("2.5T 스탠다드","4,890만원"),CarTrim("3.3T 마이스터","6,090만원")]),
    CarModel(name:"Sportage", price:"₩2,877만~", tagline:"패밀리 SUV 베스트셀러", hp:150, torque:19.9, z100:9.5, topSpeed:180, fuel:"가솔린/디젤", drive:"FWD/AWD", trims:[CarTrim("트렌디","2,877만원"),CarTrim("프레스티지","3,290만원"),CarTrim("시그니처","3,790만원")]),
  ]),
  CarBrand(name: "Genesis", color: const Color(0xFF3C3489), models: [
    CarModel(name:"GV80 Coupe", price:"₩8,500만~", tagline:"럭셔리 SUV 쿠페", hp:380, torque:54, z100:5.5, topSpeed:240, fuel:"가솔린 터보", drive:"AWD", trims:[CarTrim("3.5T 스탠다드","8,500만원"),CarTrim("3.5T 프레스티지","9,300만원")]),
    CarModel(name:"G80", price:"₩6,200만~", tagline:"한국 최고의 세단", hp:304, torque:43, z100:5.9, topSpeed:240, fuel:"가솔린/전기", drive:"RWD/AWD", trims:[CarTrim("2.5T 스탠다드","6,200만원"),CarTrim("3.5T 어드밴스드","7,500만원"),CarTrim("Electrified","8,500만원")]),
    CarModel(name:"GV60", price:"₩6,977만~", tagline:"전기 SUV의 새 기준", hp:320, torque:61, z100:4.0, topSpeed:188, fuel:"순수 전기", drive:"AWD", trims:[CarTrim("스탠다드","6,977만원"),CarTrim("퍼포먼스","7,777만원")]),
  ]),
  CarBrand(name: "BMW", color: const Color(0xFF0C447C), models: [
    CarModel(name:"M4 Competition", price:"₩1억 1,200만~", tagline:"궁극의 퍼포먼스 쿠페", hp:510, torque:66, z100:3.9, topSpeed:290, fuel:"가솔린 트윈터보", drive:"RWD/xDrive", trims:[CarTrim("M4 컴페티션","11,200만원"),CarTrim("M4 xDrive","11,800만원")]),
    CarModel(name:"3 Series", price:"₩5,690만~", tagline:"비즈니스 세단의 기준", hp:258, torque:40, z100:5.8, topSpeed:250, fuel:"가솔린/디젤", drive:"RWD/xDrive", trims:[CarTrim("320i","5,690만원"),CarTrim("330i M스포츠","6,590만원"),CarTrim("340i","7,490만원")]),
    CarModel(name:"X5 M60i", price:"₩1억 3,900만~", tagline:"럭셔리 스포츠 SUV", hp:530, torque:75, z100:4.3, topSpeed:250, fuel:"가솔린 V8", drive:"xDrive", trims:[CarTrim("X5 M60i","13,900만원"),CarTrim("X5 M Competition","17,200만원")]),
  ]),
  CarBrand(name: "Mercedes", color: const Color(0xFF3B6D11), models: [
    CarModel(name:"AMG C63", price:"₩1억 1,800만~", tagline:"AMG 퍼포먼스 세단", hp:680, torque:100, z100:3.4, topSpeed:250, fuel:"플러그인 하이브리드", drive:"RWD", trims:[CarTrim("AMG C63 S E퍼포먼스","11,800만원")]),
    CarModel(name:"E-Class", price:"₩8,100만~", tagline:"프리미엄 비즈니스 세단", hp:258, torque:40, z100:6.2, topSpeed:250, fuel:"가솔린/디젤", drive:"RWD/4MATIC", trims:[CarTrim("E200","8,100만원"),CarTrim("E220d","8,500만원"),CarTrim("E450 4MATIC","10,200만원")]),
    CarModel(name:"GLE", price:"₩9,990만~", tagline:"럭셔리 SUV의 대명사", hp:367, torque:51, z100:5.7, topSpeed:250, fuel:"가솔린/하이브리드", drive:"4MATIC", trims:[CarTrim("GLE 450","9,990만원"),CarTrim("GLE 53 AMG","12,400만원")]),
  ]),
  CarBrand(name: "Audi", color: const Color(0xFF5F5E5A), models: [
    CarModel(name:"RS6 Avant", price:"₩1억 4,300만~", tagline:"최강의 웨건", hp:630, torque:85, z100:3.4, topSpeed:280, fuel:"가솔린 터보 V8", drive:"quattro AWD", trims:[CarTrim("RS6 Avant","14,300만원"),CarTrim("RS6 퍼포먼스","16,500만원")]),
    CarModel(name:"R8 V10", price:"₩2억 3,700만~", tagline:"람보르기니 DNA 슈퍼카", hp:620, torque:57, z100:3.1, topSpeed:330, fuel:"가솔린 NA V10", drive:"quattro AWD", trims:[CarTrim("R8 V10 퍼포먼스","23,700만원")]),
    CarModel(name:"e-tron GT", price:"₩1억 3,900만~", tagline:"전기 그란투리스모", hp:598, torque:83, z100:3.3, topSpeed:250, fuel:"순수 전기", drive:"quattro AWD", trims:[CarTrim("e-tron GT","13,900만원"),CarTrim("RS e-tron GT","17,200만원")]),
  ]),
  CarBrand(name: "Porsche", color: const Color(0xFF993C1D), models: [
    CarModel(name:"911 GT3", price:"₩2억 3,800만~", tagline:"서킷의 제왕", hp:510, torque:47, z100:3.4, topSpeed:318, fuel:"가솔린 NA", drive:"RWD", trims:[CarTrim("911 GT3","23,800만원"),CarTrim("911 GT3 RS","31,500만원")]),
    CarModel(name:"Taycan Turbo S", price:"₩2억 500만~", tagline:"전기 포르쉐의 진수", hp:761, torque:106, z100:2.8, topSpeed:260, fuel:"순수 전기", drive:"AWD", trims:[CarTrim("Taycan Turbo","17,200만원"),CarTrim("Taycan Turbo S","20,500만원")]),
    CarModel(name:"Cayenne GTS", price:"₩1억 5,200만~", tagline:"스포츠 SUV 원조", hp:460, torque:62, z100:4.5, topSpeed:270, fuel:"가솔린 터보", drive:"AWD", trims:[CarTrim("Cayenne GTS","15,200만원"),CarTrim("Cayenne Turbo","18,900만원")]),
  ]),
  CarBrand(name: "Ferrari", color: const Color(0xFFA32D2D), models: [
    CarModel(name:"SF90 Stradale", price:"₩5억 6,000만~", tagline:"Ferrari 최강 하이브리드", hp:1000, torque:80, z100:2.5, topSpeed:340, fuel:"플러그인 하이브리드", drive:"AWD", trims:[CarTrim("SF90 Stradale","56,000만원"),CarTrim("SF90 Spider","62,000만원")]),
    CarModel(name:"296 GTB", price:"₩3억 2,000만~", tagline:"V6 하이브리드 슈퍼카", hp:830, torque:74, z100:2.9, topSpeed:330, fuel:"플러그인 하이브리드", drive:"RWD", trims:[CarTrim("296 GTB","32,000만원"),CarTrim("296 GTS","35,500만원")]),
    CarModel(name:"Roma", price:"₩2억 6,000만~", tagline:"로마의 우아함", hp:620, torque:76, z100:3.4, topSpeed:320, fuel:"가솔린 터보 V8", drive:"RWD", trims:[CarTrim("Roma","26,000만원"),CarTrim("Roma Spider","29,500만원")]),
  ]),
  CarBrand(name: "Lamborghini", color: const Color(0xFFBA7517), models: [
    CarModel(name:"Huracán STO", price:"₩4억 5,000만~", tagline:"서킷 DNA 슈퍼카", hp:640, torque:57, z100:3.0, topSpeed:310, fuel:"가솔린 NA V10", drive:"RWD", trims:[CarTrim("Huracán STO","45,000만원")]),
    CarModel(name:"Urus S", price:"₩3억 1,000만~", tagline:"슈퍼 SUV의 원조", hp:666, torque:86, z100:3.5, topSpeed:305, fuel:"가솔린 터보 V8", drive:"AWD", trims:[CarTrim("Urus S","31,000만원"),CarTrim("Urus Performante","36,000만원")]),
    CarModel(name:"Revuelto", price:"₩6억 5,000만~", tagline:"아벤타도르의 후계자", hp:1015, torque:74, z100:2.5, topSpeed:350, fuel:"PHEV V12", drive:"AWD", trims:[CarTrim("Revuelto","65,000만원")]),
  ]),
  CarBrand(name: "Volvo", color: const Color(0xFF085041), models: [
    CarModel(name:"XC90 Recharge", price:"₩9,890만~", tagline:"안전의 대명사 SUV", hp:455, torque:71, z100:5.6, topSpeed:180, fuel:"플러그인 하이브리드", drive:"AWD", trims:[CarTrim("T8 인스크립션","9,890만원"),CarTrim("T8 얼티메이트","10,990만원")]),
    CarModel(name:"C40 Recharge", price:"₩7,190만~", tagline:"순수 전기 쿠페 SUV", hp:408, torque:67, z100:4.7, topSpeed:180, fuel:"순수 전기", drive:"AWD", trims:[CarTrim("싱글모터","6,490만원"),CarTrim("트윈모터","7,190만원")]),
    CarModel(name:"S60 Recharge", price:"₩6,690만~", tagline:"스칸디나비안 스포츠 세단", hp:455, torque:71, z100:4.4, topSpeed:180, fuel:"플러그인 하이브리드", drive:"AWD", trims:[CarTrim("T8 R-Design","6,690만원"),CarTrim("T8 인스크립션","7,290만원")]),
  ]),
  CarBrand(name: "Tesla", color: const Color(0xFFD85A30), models: [
    CarModel(name:"Model S Plaid", price:"₩1억 5,999만~", tagline:"세계 최속 양산 전기차", hp:1020, torque:130, z100:2.1, topSpeed:322, fuel:"순수 전기", drive:"AWD", trims:[CarTrim("Model S Plaid","15,999만원")]),
    CarModel(name:"Model 3", price:"₩5,999만~", tagline:"전기차 대중화의 선봉", hp:358, torque:53, z100:4.4, topSpeed:225, fuel:"순수 전기", drive:"RWD/AWD", trims:[CarTrim("RWD","5,999만원"),CarTrim("롱레인지 AWD","6,999만원"),CarTrim("퍼포먼스","7,999만원")]),
    CarModel(name:"Model Y", price:"₩5,699만~", tagline:"세계 판매 1위 전기 SUV", hp:299, torque:42, z100:5.0, topSpeed:217, fuel:"순수 전기", drive:"RWD/AWD", trims:[CarTrim("RWD","5,699만원"),CarTrim("롱레인지 AWD","6,499만원"),CarTrim("퍼포먼스","6,999만원")]),
  ]),
  CarBrand(name: "Toyota", color: const Color(0xFF854F0B), models: [
    CarModel(name:"GR86", price:"₩3,990만~", tagline:"순수 드라이빙의 즐거움", hp:234, torque:25, z100:6.3, topSpeed:226, fuel:"가솔린 NA", drive:"RWD", trims:[CarTrim("GR86 RZ","3,990만원")]),
    CarModel(name:"GR Supra", price:"₩7,990만~", tagline:"레전드의 귀환", hp:387, torque:50, z100:4.3, topSpeed:250, fuel:"가솔린 터보", drive:"RWD", trims:[CarTrim("GR Supra 3.0","7,990만원"),CarTrim("GR Supra A91-MT","8,790만원")]),
    CarModel(name:"RAV4 PHEV", price:"₩4,990만~", tagline:"글로벌 베스트셀러 SUV", hp:306, torque:40, z100:6.0, topSpeed:180, fuel:"플러그인 하이브리드", drive:"AWD", trims:[CarTrim("GX","4,990만원"),CarTrim("XLE 프리미엄","5,490만원")]),
  ]),
  CarBrand(name: "Honda", color: const Color(0xFF639922), models: [
    CarModel(name:"Civic Type R", price:"₩5,490만~", tagline:"FF 최강의 핫해치", hp:329, torque:42, z100:5.4, topSpeed:275, fuel:"가솔린 터보", drive:"FWD", trims:[CarTrim("Type R","5,490만원")]),
    CarModel(name:"NSX Type S", price:"₩2억 8,000만~", tagline:"혼다 하이브리드 슈퍼카", hp:600, torque:66, z100:2.9, topSpeed:308, fuel:"플러그인 하이브리드", drive:"AWD", trims:[CarTrim("NSX Type S","28,000만원")]),
    CarModel(name:"e:Ny1", price:"₩5,690만~", tagline:"혼다 첫 순수전기 SUV", hp:204, torque:31, z100:7.7, topSpeed:160, fuel:"순수 전기", drive:"FWD", trims:[CarTrim("EX","5,690만원"),CarTrim("어드밴스드","6,190만원")]),
  ]),
  CarBrand(name: "Nissan", color: const Color(0xFF534AB7), models: [
    CarModel(name:"GT-R Nismo", price:"₩2억 4,800만~", tagline:"갓질라 최강 버전", hp:600, torque:66, z100:2.7, topSpeed:315, fuel:"가솔린 터보 V6", drive:"AWD", trims:[CarTrim("GT-R Premium","14,500만원"),CarTrim("GT-R Nismo","24,800만원")]),
    CarModel(name:"Z", price:"₩5,490만~", tagline:"Z카 전통의 부활", hp:400, torque:50, z100:4.6, topSpeed:250, fuel:"가솔린 터보 V6", drive:"RWD", trims:[CarTrim("Z Sport","5,490만원"),CarTrim("Z Performance","6,290만원")]),
    CarModel(name:"Ariya", price:"₩5,990만~", tagline:"닛산 전기 SUV 플래그십", hp:394, torque:60, z100:5.1, topSpeed:200, fuel:"순수 전기", drive:"FWD/AWD", trims:[CarTrim("2WD","5,990만원"),CarTrim("e-4ORCE AWD","6,790만원")]),
  ]),
  CarBrand(name: "Jeep", color: const Color(0xFF27500A), models: [
    CarModel(name:"Wrangler Rubicon", price:"₩7,490만~", tagline:"오프로드의 아이콘", hp:285, torque:35, z100:7.8, topSpeed:175, fuel:"가솔린/하이브리드", drive:"4WD", trims:[CarTrim("Wrangler Sport","5,290만원"),CarTrim("Wrangler Rubicon","7,490만원")]),
    CarModel(name:"Grand Cherokee L", price:"₩8,200만~", tagline:"7인승 럭셔리 SUV", hp:357, torque:47, z100:6.5, topSpeed:210, fuel:"가솔린/PHEV", drive:"AWD", trims:[CarTrim("Limited","8,200만원"),CarTrim("Summit","9,800만원"),CarTrim("SRT","11,500만원")]),
    CarModel(name:"Gladiator", price:"₩6,490만~", tagline:"픽업 + 오프로더 조합", hp:285, torque:35, z100:8.1, topSpeed:170, fuel:"가솔린", drive:"4WD", trims:[CarTrim("Overland","6,490만원"),CarTrim("Rubicon","7,290만원")]),
  ]),
  CarBrand(name: "Ford", color: const Color(0xFF0C3566), models: [
    CarModel(name:"Mustang GT500", price:"₩1억 1,500만~", tagline:"아메리칸 머슬의 정수", hp:760, torque:85, z100:3.3, topSpeed:290, fuel:"가솔린 슈퍼차저 V8", drive:"RWD", trims:[CarTrim("Shelby GT500","11,500만원"),CarTrim("GT500 Carbon","13,200만원")]),
    CarModel(name:"Bronco Raptor", price:"₩8,990만~", tagline:"극한의 오프로드 SUV", hp:418, torque:57, z100:6.1, topSpeed:190, fuel:"가솔린 터보", drive:"4WD", trims:[CarTrim("Bronco Sport","4,990만원"),CarTrim("Bronco Raptor","8,990만원")]),
    CarModel(name:"F-150 Lightning", price:"₩7,290만~", tagline:"미국 픽업의 전기화", hp:580, torque:105, z100:4.5, topSpeed:170, fuel:"순수 전기", drive:"AWD", trims:[CarTrim("Pro","5,490만원"),CarTrim("Lariat","7,290만원"),CarTrim("Platinum","9,990만원")]),
  ]),
];

// ── 메인 화면 ──────────────────────────────────────────────
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _brandIdx = 0;
  int _modelIdx = 0;
  int _tabIdx = 0; // 0:스펙 1:사진 2:가격

  CarBrand get brand => carBrands[_brandIdx];
  CarModel get model => brand.models[_modelIdx];
  Color get brandColor => brand.color;

  // 최대값 상수 (바 차트 정규화용)
  static const double maxHp = 1020;
  static const double maxTorque = 130;
  static const double maxSpeed = 350;
  static const double maxZ = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1B2E),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildBrandScroll(),
            _buildModelScroll(),
            _buildCarVisual(),
            _buildTabBar(),
            Expanded(child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: _buildTabContent(),
            )),
            _buildNavBar(),
          ],
        ),
      ),
    );
  }

  // ── 상단 헤더 ─────────────────────────────────────────────
  Widget _buildTopBar() {
    return Container(
      color: const Color(0xFF0C1B2E),
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("MOTORA", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5)),
            const Text("16개 브랜드 · 48개 모델", style: TextStyle(fontSize: 11, color: Color(0xFF85B7EB))),
          ]),
          const Icon(Icons.search, color: Color(0xFF85B7EB), size: 22),
        ],
      ),
    );
  }

  // ── 브랜드 가로 스크롤 ────────────────────────────────────
  Widget _buildBrandScroll() {
    return Container(
      color: const Color(0xFF0C1B2E),
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: carBrands.length,
        separatorBuilder: (_, __) => const SizedBox(width: 7),
        itemBuilder: (context, i) {
          final b = carBrands[i];
          final active = i == _brandIdx;
          return GestureDetector(
            onTap: () => setState(() { _brandIdx = i; _modelIdx = 0; _tabIdx = 0; }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: active ? b.color : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: active ? b.color : const Color(0xFF1a3a5c)),
              ),
              child: Text(b.name, style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w600,
                color: active ? Colors.white : const Color(0xFF85B7EB),
              )),
            ),
          );
        },
      ),
    );
  }

  // ── 모델 가로 스크롤 ──────────────────────────────────────
  Widget _buildModelScroll() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: brand.models.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final m = brand.models[i];
          final active = i == _modelIdx;
          return GestureDetector(
            onTap: () => setState(() { _modelIdx = i; _tabIdx = 0; }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
              decoration: BoxDecoration(
                color: active ? brandColor : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: active ? brandColor : const Color(0xFF1a3a5c),
                  width: 0.5,
                ),
              ),
              child: Text(m.name, style: TextStyle(
                fontSize: 11,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                color: active ? Colors.white : const Color(0xFF85B7EB),
              )),
            ),
          );
        },
      ),
    );
  }

  // ── 차량 비주얼 카드 ──────────────────────────────────────
  Widget _buildCarVisual() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1B2E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1a3a5c)),
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // 차량 실루엣
          Center(child: CustomPaint(
            size: const Size(270, 100),
            painter: CarPainter(brandColor),
          )),
          // 가격 배지 (우상단)
          Positioned(
            top: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(color: brandColor, borderRadius: BorderRadius.circular(10)),
              child: Text(model.price, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          // 차량명 (좌하단)
          Positioned(
            bottom: 0, left: 0,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(model.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(model.tagline, style: const TextStyle(fontSize: 10, color: Color(0xFF85B7EB))),
            ]),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  // ── 탭 바 ─────────────────────────────────────────────────
  Widget _buildTabBar() {
    const tabs = ["성능 스펙", "외관/내관", "가격 비교"];
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2a2a4a), width: 0.5),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final active = i == _tabIdx;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _tabIdx = i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: active ? const Color(0xFF0C1B2E) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(tabs[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w600,
                    color: active ? Colors.white : const Color(0xFF85B7EB),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── 탭 콘텐츠 ─────────────────────────────────────────────
  Widget _buildTabContent() {
    switch (_tabIdx) {
      case 0: return _buildSpecContent();
      case 1: return _buildPhotoContent();
      case 2: return _buildPriceContent();
      default: return _buildSpecContent();
    }
  }

  // 성능 스펙 탭
  Widget _buildSpecContent() {
    return Column(children: [
      // 4분할 스펙 카드
      GridView.count(
        crossAxisCount: 2, shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 7, mainAxisSpacing: 7,
        childAspectRatio: 2.2,
        children: [
          _specCard("최고 출력", "${model.hp}", "hp"),
          _specCard("0→100 km/h", "${model.z100}", "초"),
          _specCard("최대 토크", "${model.torque}", "kgf·m"),
          _specCard("최고 속도", "${model.topSpeed}", "km/h"),
        ],
      ),
      const SizedBox(height: 10),
      // 바 차트
      _barChartCard(),
      const SizedBox(height: 9),
      // 연료/구동 메타
      Row(children: [
        Expanded(child: _metaCard("연료", model.fuel)),
        const SizedBox(width: 7),
        Expanded(child: _metaCard("구동", model.drive)),
      ]),
      const SizedBox(height: 9),
      _actionButton("경쟁 모델과 비교하기 →"),
    ]);
  }

  // 외관/내관 탭
  Widget _buildPhotoContent() {
    final views = [
      ("전면 익스테리어", 0),
      ("후면 익스테리어", 1),
      ("인테리어 대시보드", 2),
      ("인테리어 시트", 3),
    ];
    return Column(children: [
      GridView.count(
        crossAxisCount: 2, shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 8, mainAxisSpacing: 8,
        childAspectRatio: 4/3,
        children: views.map((v) => _photoBox(v.$1, v.$2)).toList(),
      ),
      const SizedBox(height: 9),
      _actionButton("디자인 상세 설명 보기 →"),
    ]);
  }

  // 가격 비교 탭
  Widget _buildPriceContent() {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF1a3a5c), width: 0.5),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("트림별 가격", style: TextStyle(fontSize: 11, color: Color(0xFF85B7EB), fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...model.trims.map((t) => Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(t.name, style: const TextStyle(fontSize: 13, color: Colors.white)),
                Text(t.price, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: brandColor)),
              ]),
            ),
            if (t != model.trims.last) Divider(color: Colors.white.withOpacity(0.08), height: 1),
          ])),
        ]),
      ),
      const SizedBox(height: 9),
      _actionButton("구매 가이드 받기 →"),
    ]);
  }

  // ── 재사용 위젯 ────────────────────────────────────────────
  Widget _specCard(String label, String value, String unit) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2a2a4a), width: 0.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF85B7EB))),
        const SizedBox(height: 2),
        RichText(text: TextSpan(children: [
          TextSpan(text: value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          TextSpan(text: " $unit", style: const TextStyle(fontSize: 10, color: Color(0xFF5F5E5A))),
        ])),
      ]),
    );
  }

  Widget _barChartCard() {
    final bars = [
      ("출력", "${model.hp} hp", model.hp / maxHp),
      ("토크", "${model.torque} kgf·m", model.torque / maxTorque),
      ("가속 (역순)", "${model.z100}초", 1.0 - (model.z100 / maxZ)),
      ("최고 속도", "${model.topSpeed} km/h", model.topSpeed / maxSpeed),
    ];
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2a2a4a), width: 0.5),
      ),
      padding: const EdgeInsets.all(13),
      child: Column(children: bars.map((b) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(b.$1, style: const TextStyle(fontSize: 11, color: Color(0xFF85B7EB))),
            Text(b.$2, style: const TextStyle(fontSize: 11, color: Color(0xFF85B7EB))),
          ]),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: b.$3.clamp(0.0, 1.0),
              minHeight: 5,
              backgroundColor: const Color(0xFF1a3a5c),
              valueColor: AlwaysStoppedAnimation<Color>(brandColor),
            ),
          ),
        ]),
      )).toList()),
    );
  }

  Widget _metaCard(String label, String value) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF162030),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF85B7EB))),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
      ]),
    );
  }

  Widget _photoBox(String label, int type) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0C1B2E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF1a3a5c), width: 0.5),
      ),
      child: Stack(children: [
        Center(child: CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: CarViewPainter(brandColor, type),
        )),
        Positioned(
          bottom: 6, left: 8,
          child: Text(label, style: const TextStyle(fontSize: 9, color: Color(0xFF85B7EB))),
        ),
      ]),
    );
  }

  Widget _actionButton(String label) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF378ADD),
          side: const BorderSide(color: Color(0xFF378ADD), width: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ),
    );
  }

  // ── 하단 네비게이션 바 ────────────────────────────────────
  Widget _buildNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF111827),
        border: Border(top: BorderSide(color: Color(0xFF2a2a4a), width: 0.5)),
      ),
      padding: const EdgeInsets.fromLTRB(0, 9, 0, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.bar_chart_rounded, "탐색", true),
          _navItem(Icons.star_border_rounded, "즐겨찾기", false),
          _navItem(Icons.person_outline_rounded, "내 차", false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool active) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 22, color: active ? const Color(0xFF378ADD) : const Color(0xFF5F5E5A)),
      const SizedBox(height: 3),
      Text(label, style: TextStyle(fontSize: 10, color: active ? const Color(0xFF378ADD) : const Color(0xFF5F5E5A))),
    ]);
  }
}

// ── 차량 실루엣 CustomPainter ─────────────────────────────
class CarPainter extends CustomPainter {
  final Color color;
  CarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final paint = Paint();

    // 차체
    paint..color = color.withOpacity(0.28)..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.08, h*0.5, w*0.84, h*0.36), const Radius.circular(6)), paint);

    // 루프
    final roofPath = Path()
      ..moveTo(w*0.20, h*0.5)
      ..cubicTo(w*0.25, h*0.18, w*0.38, h*0.16, w*0.5, h*0.16)
      ..cubicTo(w*0.62, h*0.16, w*0.75, h*0.18, w*0.80, h*0.5)
      ..close();
    paint.color = color.withOpacity(0.22);
    canvas.drawPath(roofPath, paint);

    // 외곽선
    paint..color = color.withOpacity(0.8)..style = PaintingStyle.stroke..strokeWidth = 1.5;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.08, h*0.5, w*0.84, h*0.36), const Radius.circular(6)), paint);
    canvas.drawPath(roofPath, paint);

    // 앞바퀴
    paint..color = const Color(0xFF111827)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w*0.23, h*0.88), w*0.09, paint);
    paint..color = color.withOpacity(0.8)..style = PaintingStyle.stroke..strokeWidth = 1.5;
    canvas.drawCircle(Offset(w*0.23, h*0.88), w*0.09, paint);

    // 뒷바퀴
    paint..color = const Color(0xFF111827)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w*0.77, h*0.88), w*0.09, paint);
    paint..color = color.withOpacity(0.8)..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(w*0.77, h*0.88), w*0.09, paint);

    // 전조등
    paint..color = const Color(0xFFEF9F27).withOpacity(0.85)..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.08, h*0.6, w*0.07, h*0.1), const Radius.circular(2)), paint);

    // 후미등
    paint.color = const Color(0xFFE24B4A).withOpacity(0.85);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.85, h*0.6, w*0.07, h*0.1), const Radius.circular(2)), paint);
  }

  @override
  bool shouldRepaint(CarPainter old) => old.color != color;
}

// ── 외관/내관 뷰 CustomPainter ───────────────────────────
class CarViewPainter extends CustomPainter {
  final Color color;
  final int type; // 0:전면 1:후면 2:대시보드 3:시트
  CarViewPainter(this.color, this.type);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final paint = Paint();

    switch (type) {
      case 0: // 전면
        final p = Path()
          ..moveTo(w*0.10, h*0.78)..lineTo(w*0.25, h*0.18)
          ..lineTo(w*0.75, h*0.18)..lineTo(w*0.90, h*0.78)..close();
        paint..color = color.withOpacity(0.18)..style = PaintingStyle.fill;
        canvas.drawPath(p, paint);
        paint..color = color.withOpacity(0.6)..style = PaintingStyle.stroke..strokeWidth = 1.2;
        canvas.drawPath(p, paint);
        // 헤드램프
        paint..color = const Color(0xFFEF9F27).withOpacity(0.8)..style = PaintingStyle.fill;
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.08, h*0.56, w*0.20, h*0.12), const Radius.circular(3)), paint);
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.72, h*0.56, w*0.20, h*0.12), const Radius.circular(3)), paint);
        break;
      case 1: // 후면
        paint..color = color.withOpacity(0.18)..style = PaintingStyle.fill;
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.10, h*0.35, w*0.80, h*0.45), const Radius.circular(8)), paint);
        paint..color = color.withOpacity(0.6)..style = PaintingStyle.stroke..strokeWidth = 1.2;
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.10, h*0.35, w*0.80, h*0.45), const Radius.circular(8)), paint);
        paint..color = const Color(0xFFE24B4A).withOpacity(0.85)..style = PaintingStyle.fill;
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.12, h*0.48, w*0.22, h*0.10), const Radius.circular(2)), paint);
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.66, h*0.48, w*0.22, h*0.10), const Radius.circular(2)), paint);
        break;
      case 2: // 대시보드
        paint..color = color.withOpacity(0.10)..style = PaintingStyle.fill;
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.07, h*0.28, w*0.86, h*0.55), const Radius.circular(6)), paint);
        paint..color = color.withOpacity(0.4)..style = PaintingStyle.stroke..strokeWidth = 0.8;
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.07, h*0.28, w*0.86, h*0.55), const Radius.circular(6)), paint);
        paint..color = color.withOpacity(0.20)..style = PaintingStyle.fill;
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.12, h*0.35, w*0.45, h*0.35), const Radius.circular(4)), paint);
        paint..color = color.withOpacity(0.7)..style = PaintingStyle.stroke..strokeWidth = 1.5;
        canvas.drawCircle(Offset(w*0.73, h*0.52), w*0.13, paint);
        canvas.drawCircle(Offset(w*0.73, h*0.52), w*0.06, paint);
        break;
      case 3: // 시트
        final seatPath = Path()
          ..moveTo(w*0.15, h*0.85)
          ..cubicTo(w*0.15, h*0.35, w*0.30, h*0.28, w*0.50, h*0.28)
          ..cubicTo(w*0.70, h*0.28, w*0.85, h*0.35, w*0.85, h*0.85)
          ..close();
        paint..color = color.withOpacity(0.15)..style = PaintingStyle.fill;
        canvas.drawPath(seatPath, paint);
        paint..color = color.withOpacity(0.20)..style = PaintingStyle.fill;
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(w*0.25, h*0.50, w*0.50, h*0.35), const Radius.circular(8)), paint);
        break;
    }
  }

  @override
  bool shouldRepaint(CarViewPainter old) => old.color != color || old.type != type;
}
