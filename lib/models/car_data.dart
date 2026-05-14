// ============================================================
// lib/models/car_data.dart
// 전체 브랜드/모델 데이터 + Unsplash 검색 키워드
// ============================================================

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
  // Unsplash 검색 키워드 (외관/내관 각각)
  final String exteriorKeyword;
  final String interiorKeyword;

  const CarModel({
    required this.name, required this.price, required this.tagline,
    required this.hp, required this.torque, required this.z100,
    required this.topSpeed, required this.fuel, required this.drive,
    required this.trims,
    required this.exteriorKeyword,
    required this.interiorKeyword,
  });
}

class CarBrand {
  final String name;
  final int colorValue;
  final List<CarModel> models;
  const CarBrand({required this.name, required this.colorValue, required this.models});
}

// ── 전체 데이터 ────────────────────────────────────────────
final List<CarBrand> carBrands = [

  // ── 현대 ──────────────────────────────────────────────────
  CarBrand(name: "현대", colorValue: 0xFFE24B4A, models: [
    CarModel(name:"Sonata N Line", price:"₩5,290만~", tagline:"스포티 세단의 정수", hp:290, torque:40, z100:5.1, topSpeed:250, fuel:"가솔린 터보", drive:"FWD", exteriorKeyword:"Hyundai Sonata N Line exterior", interiorKeyword:"Hyundai Sonata interior cockpit", trims:[CarTrim("N Line 스탠다드","5,290만원"),CarTrim("N Line 프리미엄","5,890만원"),CarTrim("N Line 퍼포먼스","6,290만원")]),
    CarModel(name:"IONIQ 6", price:"₩5,200만~", tagline:"전기차 혁신의 아이콘", hp:320, torque:61, z100:5.1, topSpeed:185, fuel:"순수 전기", drive:"RWD/AWD", exteriorKeyword:"Hyundai IONIQ 6 exterior", interiorKeyword:"Hyundai IONIQ 6 interior", trims:[CarTrim("스탠다드","5,200만원"),CarTrim("롱레인지 2WD","5,800만원"),CarTrim("롱레인지 AWD","6,300만원")]),
    CarModel(name:"IONIQ 5 N", price:"₩6,990만~", tagline:"고성능 전기 핫해치", hp:650, torque:75, z100:3.4, topSpeed:260, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Hyundai IONIQ 5 N exterior", interiorKeyword:"Hyundai IONIQ 5 N interior", trims:[CarTrim("IONIQ 5 N","6,990만원")]),
    CarModel(name:"Tucson", price:"₩3,099만~", tagline:"도심형 SUV 강자", hp:180, torque:27, z100:8.5, topSpeed:195, fuel:"가솔린/하이브리드", drive:"AWD", exteriorKeyword:"Hyundai Tucson SUV exterior", interiorKeyword:"Hyundai Tucson interior", trims:[CarTrim("모던","3,099만원"),CarTrim("프리미엄","3,590만원"),CarTrim("인스퍼레이션","3,990만원")]),
    CarModel(name:"Palisade", price:"₩4,190만~", tagline:"대형 패밀리 SUV의 왕", hp:291, torque:45, z100:7.1, topSpeed:200, fuel:"가솔린/디젤", drive:"AWD", exteriorKeyword:"Hyundai Palisade exterior", interiorKeyword:"Hyundai Palisade interior", trims:[CarTrim("프리미엄","4,190만원"),CarTrim("캘리그라피","5,190만원")]),
    CarModel(name:"Elantra N", price:"₩3,690만~", tagline:"N 퍼포먼스 세단", hp:276, torque:40, z100:5.3, topSpeed:250, fuel:"가솔린 터보", drive:"FWD", exteriorKeyword:"Hyundai Elantra N exterior", interiorKeyword:"Hyundai Elantra N interior", trims:[CarTrim("Elantra N","3,690만원"),CarTrim("Elantra N DCT","3,990만원")]),
  ]),

  // ── 기아 ──────────────────────────────────────────────────
  CarBrand(name: "기아", colorValue: 0xFF185FA5, models: [
    CarModel(name:"EV6 GT", price:"₩7,490만~", tagline:"달리는 예술", hp:585, torque:74, z100:3.5, topSpeed:260, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Kia EV6 GT exterior", interiorKeyword:"Kia EV6 GT interior", trims:[CarTrim("GT 스탠다드","7,490만원"),CarTrim("GT 풀옵션","8,290만원")]),
    CarModel(name:"EV9", price:"₩7,377만~", tagline:"대형 전기 SUV 플래그십", hp:379, torque:70, z100:5.3, topSpeed:200, fuel:"순수 전기", drive:"RWD/AWD", exteriorKeyword:"Kia EV9 exterior", interiorKeyword:"Kia EV9 interior", trims:[CarTrim("에어","7,377만원"),CarTrim("어스","8,377만원"),CarTrim("GT라인","9,077만원")]),
    CarModel(name:"Stinger", price:"₩4,890만~", tagline:"그란투리스모의 감동", hp:370, torque:52, z100:4.9, topSpeed:270, fuel:"가솔린 터보", drive:"RWD", exteriorKeyword:"Kia Stinger exterior", interiorKeyword:"Kia Stinger interior", trims:[CarTrim("2.5T 스탠다드","4,890만원"),CarTrim("3.3T 마이스터","6,090만원")]),
    CarModel(name:"Sportage", price:"₩2,877만~", tagline:"패밀리 SUV 베스트셀러", hp:150, torque:19.9, z100:9.5, topSpeed:180, fuel:"가솔린/디젤", drive:"FWD/AWD", exteriorKeyword:"Kia Sportage exterior", interiorKeyword:"Kia Sportage interior", trims:[CarTrim("트렌디","2,877만원"),CarTrim("프레스티지","3,290만원"),CarTrim("시그니처","3,790만원")]),
    CarModel(name:"K8", price:"₩3,819만~", tagline:"플래그십 세단의 품격", hp:266, torque:31, z100:6.5, topSpeed:220, fuel:"가솔린/하이브리드", drive:"FWD/AWD", exteriorKeyword:"Kia K8 sedan exterior", interiorKeyword:"Kia K8 interior", trims:[CarTrim("프레스티지","3,819만원"),CarTrim("노블레스","4,319만원"),CarTrim("시그니처","4,819만원")]),
    CarModel(name:"Carnival", price:"₩3,590만~", tagline:"프리미엄 패밀리 MPV", hp:294, torque:44, z100:8.0, topSpeed:195, fuel:"가솔린/디젤", drive:"FWD", exteriorKeyword:"Kia Carnival minivan exterior", interiorKeyword:"Kia Carnival interior lounge", trims:[CarTrim("프레스티지","3,590만원"),CarTrim("노블레스","4,090만원"),CarTrim("시그니처","4,590만원")]),
  ]),

  // ── Genesis ───────────────────────────────────────────────
  CarBrand(name: "Genesis", colorValue: 0xFF3C3489, models: [
    CarModel(name:"GV80 Coupe", price:"₩8,500만~", tagline:"럭셔리 SUV 쿠페", hp:380, torque:54, z100:5.5, topSpeed:240, fuel:"가솔린 터보", drive:"AWD", exteriorKeyword:"Genesis GV80 Coupe exterior", interiorKeyword:"Genesis GV80 interior luxury", trims:[CarTrim("3.5T 스탠다드","8,500만원"),CarTrim("3.5T 프레스티지","9,300만원")]),
    CarModel(name:"G80", price:"₩6,200만~", tagline:"한국 최고의 세단", hp:304, torque:43, z100:5.9, topSpeed:240, fuel:"가솔린/전기", drive:"RWD/AWD", exteriorKeyword:"Genesis G80 sedan exterior", interiorKeyword:"Genesis G80 interior", trims:[CarTrim("2.5T 스탠다드","6,200만원"),CarTrim("3.5T 어드밴스드","7,500만원"),CarTrim("Electrified","8,500만원")]),
    CarModel(name:"GV60", price:"₩6,977만~", tagline:"전기 SUV의 새 기준", hp:320, torque:61, z100:4.0, topSpeed:188, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Genesis GV60 electric exterior", interiorKeyword:"Genesis GV60 interior", trims:[CarTrim("스탠다드","6,977만원"),CarTrim("퍼포먼스","7,777만원")]),
    CarModel(name:"G90", price:"₩1억 3,100만~", tagline:"최고급 플래그십 세단", hp:425, torque:62, z100:5.1, topSpeed:250, fuel:"가솔린 터보", drive:"RWD/AWD", exteriorKeyword:"Genesis G90 flagship sedan exterior", interiorKeyword:"Genesis G90 interior luxury", trims:[CarTrim("3.5T 프레스티지","13,100만원"),CarTrim("3.5T 얼티메이트","15,900만원")]),
    CarModel(name:"GV70", price:"₩5,500만~", tagline:"스포츠 미드사이즈 SUV", hp:304, torque:43, z100:5.6, topSpeed:240, fuel:"가솔린/전기", drive:"AWD", exteriorKeyword:"Genesis GV70 exterior", interiorKeyword:"Genesis GV70 interior", trims:[CarTrim("2.5T 스탠다드","5,500만원"),CarTrim("3.5T 스포츠","7,200만원"),CarTrim("Electrified","7,700만원")]),
    CarModel(name:"G70", price:"₩4,300만~", tagline:"스포츠 세단의 정수", hp:252, torque:36, z100:6.0, topSpeed:240, fuel:"가솔린 터보", drive:"RWD/AWD", exteriorKeyword:"Genesis G70 sport sedan exterior", interiorKeyword:"Genesis G70 interior", trims:[CarTrim("2.0T 스탠다드","4,300만원"),CarTrim("3.3T 스포츠","5,900만원")]),
  ]),

  // ── BMW ───────────────────────────────────────────────────
  CarBrand(name: "BMW", colorValue: 0xFF0C447C, models: [
    CarModel(name:"M4 Competition", price:"₩1억 1,200만~", tagline:"궁극의 퍼포먼스 쿠페", hp:510, torque:66, z100:3.9, topSpeed:290, fuel:"가솔린 트윈터보", drive:"RWD/xDrive", exteriorKeyword:"BMW M4 Competition exterior", interiorKeyword:"BMW M4 interior cockpit", trims:[CarTrim("M4 컴페티션","11,200만원"),CarTrim("M4 xDrive","11,800만원")]),
    CarModel(name:"M3 Competition", price:"₩1억 500만~", tagline:"세단 퍼포먼스의 정점", hp:510, torque:66, z100:3.9, topSpeed:290, fuel:"가솔린 트윈터보", drive:"RWD/xDrive", exteriorKeyword:"BMW M3 Competition exterior", interiorKeyword:"BMW M3 interior", trims:[CarTrim("M3 컴페티션","10,500만원"),CarTrim("M3 xDrive","11,100만원")]),
    CarModel(name:"3 Series", price:"₩5,690만~", tagline:"비즈니스 세단의 기준", hp:258, torque:40, z100:5.8, topSpeed:250, fuel:"가솔린/디젤", drive:"RWD/xDrive", exteriorKeyword:"BMW 3 Series exterior", interiorKeyword:"BMW 3 Series interior", trims:[CarTrim("320i","5,690만원"),CarTrim("330i M스포츠","6,590만원"),CarTrim("340i","7,490만원")]),
    CarModel(name:"X5 M60i", price:"₩1억 3,900만~", tagline:"럭셔리 스포츠 SUV", hp:530, torque:75, z100:4.3, topSpeed:250, fuel:"가솔린 V8", drive:"xDrive", exteriorKeyword:"BMW X5 M exterior", interiorKeyword:"BMW X5 interior luxury", trims:[CarTrim("X5 M60i","13,900만원"),CarTrim("X5 M Competition","17,200만원")]),
    CarModel(name:"i4 M50", price:"₩9,350만~", tagline:"전기 퍼포먼스 세단", hp:544, torque:80, z100:3.9, topSpeed:225, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"BMW i4 M50 exterior", interiorKeyword:"BMW i4 interior", trims:[CarTrim("i4 M50","9,350만원")]),
    CarModel(name:"XM", price:"₩2억 3,900만~", tagline:"BMW 최강 하이브리드 SUV", hp:748, torque:100, z100:4.3, topSpeed:250, fuel:"플러그인 하이브리드", drive:"xDrive", exteriorKeyword:"BMW XM exterior", interiorKeyword:"BMW XM interior luxury", trims:[CarTrim("XM","23,900만원"),CarTrim("XM Label Red","30,500만원")]),
  ]),

  // ── Mercedes ──────────────────────────────────────────────
  CarBrand(name: "Mercedes", colorValue: 0xFF3B6D11, models: [
    CarModel(name:"AMG C63", price:"₩1억 1,800만~", tagline:"AMG 퍼포먼스 세단", hp:680, torque:100, z100:3.4, topSpeed:250, fuel:"플러그인 하이브리드", drive:"RWD", exteriorKeyword:"Mercedes AMG C63 exterior", interiorKeyword:"Mercedes AMG C63 interior", trims:[CarTrim("AMG C63 S E퍼포먼스","11,800만원")]),
    CarModel(name:"AMG GT 63", price:"₩2억 4,900만~", tagline:"4도어 GT 퍼포먼스", hp:816, torque:91, z100:2.8, topSpeed:316, fuel:"플러그인 하이브리드", drive:"4MATIC+", exteriorKeyword:"Mercedes AMG GT 63 exterior", interiorKeyword:"Mercedes AMG GT interior", trims:[CarTrim("AMG GT 63","24,900만원"),CarTrim("AMG GT 63 PRO","28,500만원")]),
    CarModel(name:"E-Class", price:"₩8,100만~", tagline:"프리미엄 비즈니스 세단", hp:258, torque:40, z100:6.2, topSpeed:250, fuel:"가솔린/디젤", drive:"RWD/4MATIC", exteriorKeyword:"Mercedes E-Class exterior", interiorKeyword:"Mercedes E-Class interior", trims:[CarTrim("E200","8,100만원"),CarTrim("E220d","8,500만원"),CarTrim("E450 4MATIC","10,200만원")]),
    CarModel(name:"S-Class", price:"₩1억 7,000만~", tagline:"최고급 플래그십 세단", hp:435, torque:52, z100:4.9, topSpeed:250, fuel:"가솔린/하이브리드", drive:"RWD/4MATIC", exteriorKeyword:"Mercedes S-Class exterior", interiorKeyword:"Mercedes S-Class interior luxury", trims:[CarTrim("S450 4MATIC","17,000만원"),CarTrim("S580 4MATIC","21,500만원"),CarTrim("Maybach S680","37,000만원")]),
    CarModel(name:"GLE", price:"₩9,990만~", tagline:"럭셔리 SUV의 대명사", hp:367, torque:51, z100:5.7, topSpeed:250, fuel:"가솔린/하이브리드", drive:"4MATIC", exteriorKeyword:"Mercedes GLE SUV exterior", interiorKeyword:"Mercedes GLE interior", trims:[CarTrim("GLE 450","9,990만원"),CarTrim("GLE 53 AMG","12,400만원")]),
    CarModel(name:"EQS 580", price:"₩1억 9,500만~", tagline:"전기 플래그십 세단", hp:523, torque:86, z100:4.3, topSpeed:210, fuel:"순수 전기", drive:"4MATIC", exteriorKeyword:"Mercedes EQS exterior", interiorKeyword:"Mercedes EQS hyperscreen interior", trims:[CarTrim("EQS 450+","16,500만원"),CarTrim("EQS 580 4MATIC","19,500만원")]),
  ]),

  // ── Audi ──────────────────────────────────────────────────
  CarBrand(name: "Audi", colorValue: 0xFF5F5E5A, models: [
    CarModel(name:"RS6 Avant", price:"₩1억 4,300만~", tagline:"최강의 웨건", hp:630, torque:85, z100:3.4, topSpeed:280, fuel:"가솔린 터보 V8", drive:"quattro AWD", exteriorKeyword:"Audi RS6 Avant exterior", interiorKeyword:"Audi RS6 Avant interior", trims:[CarTrim("RS6 Avant","14,300만원"),CarTrim("RS6 퍼포먼스","16,500만원")]),
    CarModel(name:"R8 V10", price:"₩2억 3,700만~", tagline:"람보르기니 DNA 슈퍼카", hp:620, torque:57, z100:3.1, topSpeed:330, fuel:"가솔린 NA V10", drive:"quattro AWD", exteriorKeyword:"Audi R8 V10 exterior supercar", interiorKeyword:"Audi R8 interior cockpit", trims:[CarTrim("R8 V10 퍼포먼스","23,700만원")]),
    CarModel(name:"e-tron GT", price:"₩1억 3,900만~", tagline:"전기 그란투리스모", hp:598, torque:83, z100:3.3, topSpeed:250, fuel:"순수 전기", drive:"quattro AWD", exteriorKeyword:"Audi e-tron GT exterior", interiorKeyword:"Audi e-tron GT interior", trims:[CarTrim("e-tron GT","13,900만원"),CarTrim("RS e-tron GT","17,200만원")]),
    CarModel(name:"RS3", price:"₩7,900만~", tagline:"최강의 컴팩트 세단", hp:400, torque:50, z100:3.8, topSpeed:290, fuel:"가솔린 터보", drive:"quattro AWD", exteriorKeyword:"Audi RS3 exterior", interiorKeyword:"Audi RS3 interior", trims:[CarTrim("RS3 세단","7,900만원"),CarTrim("RS3 스포트백","8,100만원")]),
    CarModel(name:"Q8", price:"₩1억 1,900만~", tagline:"플래그십 SUV 쿠페", hp:340, torque:50, z100:5.9, topSpeed:250, fuel:"가솔린/디젤", drive:"quattro AWD", exteriorKeyword:"Audi Q8 exterior", interiorKeyword:"Audi Q8 interior luxury", trims:[CarTrim("Q8 55 TFSI","11,900만원"),CarTrim("RSQ8","19,300만원")]),
    CarModel(name:"TT RS", price:"₩9,900만~", tagline:"아이코닉 스포츠 쿠페", hp:400, torque:48, z100:3.7, topSpeed:280, fuel:"가솔린 터보", drive:"quattro AWD", exteriorKeyword:"Audi TT RS exterior", interiorKeyword:"Audi TT RS interior cockpit", trims:[CarTrim("TT RS 쿠페","9,900만원"),CarTrim("TT RS 로드스터","10,500만원")]),
  ]),

  // ── Porsche ───────────────────────────────────────────────
  CarBrand(name: "Porsche", colorValue: 0xFF993C1D, models: [
    CarModel(name:"911 GT3", price:"₩2억 3,800만~", tagline:"서킷의 제왕", hp:510, torque:47, z100:3.4, topSpeed:318, fuel:"가솔린 NA", drive:"RWD", exteriorKeyword:"Porsche 911 GT3 exterior track", interiorKeyword:"Porsche 911 GT3 interior cockpit", trims:[CarTrim("911 GT3","23,800만원"),CarTrim("911 GT3 RS","31,500만원")]),
    CarModel(name:"911 Turbo S", price:"₩3억 500만~", tagline:"올라운드 최강 스포츠카", hp:650, torque:80, z100:2.7, topSpeed:330, fuel:"가솔린 트윈터보", drive:"AWD", exteriorKeyword:"Porsche 911 Turbo S exterior", interiorKeyword:"Porsche 911 Turbo S interior", trims:[CarTrim("911 Turbo S","30,500만원"),CarTrim("911 Turbo S 카브리올레","33,000만원")]),
    CarModel(name:"Taycan Turbo S", price:"₩2억 500만~", tagline:"전기 포르쉐의 진수", hp:761, torque:106, z100:2.8, topSpeed:260, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Porsche Taycan Turbo S exterior", interiorKeyword:"Porsche Taycan interior", trims:[CarTrim("Taycan Turbo","17,200만원"),CarTrim("Taycan Turbo S","20,500만원")]),
    CarModel(name:"Cayenne GTS", price:"₩1억 5,200만~", tagline:"스포츠 SUV 원조", hp:460, torque:62, z100:4.5, topSpeed:270, fuel:"가솔린 터보", drive:"AWD", exteriorKeyword:"Porsche Cayenne GTS exterior", interiorKeyword:"Porsche Cayenne interior", trims:[CarTrim("Cayenne GTS","15,200만원"),CarTrim("Cayenne Turbo","18,900만원")]),
    CarModel(name:"Panamera GTS", price:"₩1억 9,800만~", tagline:"4도어 스포츠카의 원조", hp:480, torque:62, z100:3.8, topSpeed:296, fuel:"가솔린 터보 V8", drive:"AWD", exteriorKeyword:"Porsche Panamera GTS exterior", interiorKeyword:"Porsche Panamera interior luxury", trims:[CarTrim("Panamera GTS","19,800만원"),CarTrim("Panamera Turbo S","30,200만원")]),
    CarModel(name:"718 Cayman GT4", price:"₩1억 2,800만~", tagline:"미드십 순수 드라이빙", hp:420, torque:43, z100:3.9, topSpeed:304, fuel:"가솔린 NA", drive:"RWD", exteriorKeyword:"Porsche 718 Cayman GT4 exterior", interiorKeyword:"Porsche Cayman GT4 interior", trims:[CarTrim("718 Cayman GT4","12,800만원"),CarTrim("718 Cayman GT4 RS","16,500만원")]),
  ]),

  // ── Ferrari ───────────────────────────────────────────────
  CarBrand(name: "Ferrari", colorValue: 0xFFA32D2D, models: [
    CarModel(name:"SF90 Stradale", price:"₩5억 6,000만~", tagline:"Ferrari 최강 하이브리드", hp:1000, torque:80, z100:2.5, topSpeed:340, fuel:"플러그인 하이브리드", drive:"AWD", exteriorKeyword:"Ferrari SF90 Stradale exterior red", interiorKeyword:"Ferrari SF90 interior cockpit", trims:[CarTrim("SF90 Stradale","56,000만원"),CarTrim("SF90 Spider","62,000만원")]),
    CarModel(name:"296 GTB", price:"₩3억 2,000만~", tagline:"V6 하이브리드 슈퍼카", hp:830, torque:74, z100:2.9, topSpeed:330, fuel:"플러그인 하이브리드", drive:"RWD", exteriorKeyword:"Ferrari 296 GTB exterior", interiorKeyword:"Ferrari 296 GTB interior", trims:[CarTrim("296 GTB","32,000만원"),CarTrim("296 GTS","35,500만원")]),
    CarModel(name:"Roma Spider", price:"₩2억 9,500만~", tagline:"로마의 우아한 오픈카", hp:620, torque:76, z100:3.4, topSpeed:320, fuel:"가솔린 터보 V8", drive:"RWD", exteriorKeyword:"Ferrari Roma Spider exterior", interiorKeyword:"Ferrari Roma interior", trims:[CarTrim("Roma","26,000만원"),CarTrim("Roma Spider","29,500만원")]),
    CarModel(name:"Purosangue", price:"₩5억 5,000만~", tagline:"페라리 최초의 SUV", hp:725, torque:72, z100:3.3, topSpeed:310, fuel:"가솔린 NA V12", drive:"AWD", exteriorKeyword:"Ferrari Purosangue SUV exterior", interiorKeyword:"Ferrari Purosangue interior luxury", trims:[CarTrim("Purosangue","55,000만원")]),
    CarModel(name:"812 Competizione", price:"₩5억 8,000만~", tagline:"V12 NA 최후의 걸작", hp:830, torque:72, z100:2.85, topSpeed:340, fuel:"가솔린 NA V12", drive:"RWD", exteriorKeyword:"Ferrari 812 Competizione exterior", interiorKeyword:"Ferrari 812 interior", trims:[CarTrim("812 Competizione","58,000만원")]),
    CarModel(name:"F8 Tributo", price:"₩3억 4,000만~", tagline:"미드십 V8 슈퍼카", hp:720, torque:77, z100:2.9, topSpeed:340, fuel:"가솔린 터보 V8", drive:"RWD", exteriorKeyword:"Ferrari F8 Tributo exterior", interiorKeyword:"Ferrari F8 Tributo interior", trims:[CarTrim("F8 Tributo","34,000만원"),CarTrim("F8 Spider","37,500만원")]),
  ]),

  // ── Lamborghini ───────────────────────────────────────────
  CarBrand(name: "Lamborghini", colorValue: 0xFFBA7517, models: [
    CarModel(name:"Revuelto", price:"₩6억 5,000만~", tagline:"아벤타도르의 후계자", hp:1015, torque:74, z100:2.5, topSpeed:350, fuel:"PHEV V12", drive:"AWD", exteriorKeyword:"Lamborghini Revuelto exterior", interiorKeyword:"Lamborghini Revuelto interior", trims:[CarTrim("Revuelto","65,000만원")]),
    CarModel(name:"Huracán STO", price:"₩4억 5,000만~", tagline:"서킷 DNA 슈퍼카", hp:640, torque:57, z100:3.0, topSpeed:310, fuel:"가솔린 NA V10", drive:"RWD", exteriorKeyword:"Lamborghini Huracan STO exterior", interiorKeyword:"Lamborghini Huracan interior cockpit", trims:[CarTrim("Huracán STO","45,000만원")]),
    CarModel(name:"Urus S", price:"₩3억 1,000만~", tagline:"슈퍼 SUV의 원조", hp:666, torque:86, z100:3.5, topSpeed:305, fuel:"가솔린 터보 V8", drive:"AWD", exteriorKeyword:"Lamborghini Urus S exterior", interiorKeyword:"Lamborghini Urus interior luxury", trims:[CarTrim("Urus S","31,000만원"),CarTrim("Urus Performante","36,000만원")]),
    CarModel(name:"Sterrato", price:"₩4억 2,000만~", tagline:"오프로드 슈퍼카", hp:610, torque:57, z100:3.4, topSpeed:260, fuel:"가솔린 NA V10", drive:"AWD", exteriorKeyword:"Lamborghini Sterrato offroad exterior", interiorKeyword:"Lamborghini Sterrato interior", trims:[CarTrim("Sterrato","42,000만원")]),
    CarModel(name:"Huracán Tecnica", price:"₩3억 5,000만~", tagline:"V10 날것의 즐거움", hp:640, torque:57, z100:3.2, topSpeed:325, fuel:"가솔린 NA V10", drive:"RWD", exteriorKeyword:"Lamborghini Huracan Tecnica exterior", interiorKeyword:"Lamborghini Huracan interior", trims:[CarTrim("Huracán Tecnica","35,000만원")]),
    CarModel(name:"SC63", price:"₩문의~", tagline:"르망 레이스카", hp:1000, torque:100, z100:2.0, topSpeed:350, fuel:"하이브리드 V8", drive:"AWD", exteriorKeyword:"Lamborghini SC63 race car exterior", interiorKeyword:"Lamborghini racing car cockpit interior", trims:[CarTrim("SC63 레이스","문의")]),
  ]),

  // ── Volvo ─────────────────────────────────────────────────
  CarBrand(name: "Volvo", colorValue: 0xFF085041, models: [
    CarModel(name:"XC90 Recharge", price:"₩9,890만~", tagline:"안전의 대명사 SUV", hp:455, torque:71, z100:5.6, topSpeed:180, fuel:"플러그인 하이브리드", drive:"AWD", exteriorKeyword:"Volvo XC90 Recharge exterior", interiorKeyword:"Volvo XC90 interior luxury", trims:[CarTrim("T8 인스크립션","9,890만원"),CarTrim("T8 얼티메이트","10,990만원")]),
    CarModel(name:"EX90", price:"₩1억 2,000만~", tagline:"볼보 순수전기 플래그십", hp:517, torque:91, z100:4.9, topSpeed:180, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Volvo EX90 electric SUV exterior", interiorKeyword:"Volvo EX90 interior", trims:[CarTrim("EX90 트윈모터","12,000만원"),CarTrim("EX90 퍼포먼스","13,500만원")]),
    CarModel(name:"C40 Recharge", price:"₩7,190만~", tagline:"순수 전기 쿠페 SUV", hp:408, torque:67, z100:4.7, topSpeed:180, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Volvo C40 Recharge exterior", interiorKeyword:"Volvo C40 interior", trims:[CarTrim("싱글모터","6,490만원"),CarTrim("트윈모터","7,190만원")]),
    CarModel(name:"S60 Recharge", price:"₩6,690만~", tagline:"스칸디나비안 스포츠 세단", hp:455, torque:71, z100:4.4, topSpeed:180, fuel:"플러그인 하이브리드", drive:"AWD", exteriorKeyword:"Volvo S60 Recharge exterior", interiorKeyword:"Volvo S60 interior", trims:[CarTrim("T8 R-Design","6,690만원"),CarTrim("T8 인스크립션","7,290만원")]),
    CarModel(name:"XC40 Recharge", price:"₩6,190만~", tagline:"컴팩트 전기 SUV", hp:408, torque:67, z100:4.9, topSpeed:180, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Volvo XC40 Recharge exterior", interiorKeyword:"Volvo XC40 interior", trims:[CarTrim("싱글모터","5,790만원"),CarTrim("트윈모터","6,190만원")]),
    CarModel(name:"V90 Cross Country", price:"₩7,990만~", tagline:"올라운드 럭셔리 웨건", hp:300, torque:42, z100:6.5, topSpeed:210, fuel:"마일드 하이브리드", drive:"AWD", exteriorKeyword:"Volvo V90 Cross Country exterior", interiorKeyword:"Volvo V90 interior", trims:[CarTrim("B6 AWD","7,990만원")]),
  ]),

  // ── Tesla ─────────────────────────────────────────────────
  CarBrand(name: "Tesla", colorValue: 0xFFD85A30, models: [
    CarModel(name:"Model S Plaid", price:"₩1억 5,999만~", tagline:"세계 최속 양산 전기차", hp:1020, torque:130, z100:2.1, topSpeed:322, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Tesla Model S Plaid exterior", interiorKeyword:"Tesla Model S interior yoke", trims:[CarTrim("Model S Plaid","15,999만원")]),
    CarModel(name:"Model 3", price:"₩5,999만~", tagline:"전기차 대중화의 선봉", hp:358, torque:53, z100:4.4, topSpeed:225, fuel:"순수 전기", drive:"RWD/AWD", exteriorKeyword:"Tesla Model 3 exterior", interiorKeyword:"Tesla Model 3 interior minimalist", trims:[CarTrim("RWD","5,999만원"),CarTrim("롱레인지 AWD","6,999만원"),CarTrim("퍼포먼스","7,999만원")]),
    CarModel(name:"Model Y", price:"₩5,699만~", tagline:"세계 판매 1위 전기 SUV", hp:299, torque:42, z100:5.0, topSpeed:217, fuel:"순수 전기", drive:"RWD/AWD", exteriorKeyword:"Tesla Model Y exterior", interiorKeyword:"Tesla Model Y interior", trims:[CarTrim("RWD","5,699만원"),CarTrim("롱레인지 AWD","6,499만원"),CarTrim("퍼포먼스","6,999만원")]),
    CarModel(name:"Model X Plaid", price:"₩1억 3,999만~", tagline:"팔콘윙 대형 전기 SUV", hp:1020, torque:130, z100:2.6, topSpeed:262, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Tesla Model X exterior falcon wing", interiorKeyword:"Tesla Model X interior", trims:[CarTrim("Model X","10,999만원"),CarTrim("Model X Plaid","13,999만원")]),
    CarModel(name:"Cybertruck", price:"₩8,900만~", tagline:"스테인리스 전기 픽업", hp:845, torque:130, z100:2.6, topSpeed:209, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Tesla Cybertruck exterior stainless", interiorKeyword:"Tesla Cybertruck interior", trims:[CarTrim("AWD","8,900만원"),CarTrim("Cyberbeast","10,900만원")]),
    CarModel(name:"Roadster 2", price:"₩2억~", tagline:"0-100 1.9초 하이퍼카", hp:1000, torque:130, z100:1.9, topSpeed:400, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Tesla Roadster 2 exterior concept", interiorKeyword:"Tesla Roadster interior", trims:[CarTrim("Roadster","20,000만원"),CarTrim("Founder Series","25,000만원")]),
  ]),

  // ── Toyota ────────────────────────────────────────────────
  CarBrand(name: "Toyota", colorValue: 0xFF854F0B, models: [
    CarModel(name:"GR86", price:"₩3,990만~", tagline:"순수 드라이빙의 즐거움", hp:234, torque:25, z100:6.3, topSpeed:226, fuel:"가솔린 NA", drive:"RWD", exteriorKeyword:"Toyota GR86 exterior", interiorKeyword:"Toyota GR86 interior", trims:[CarTrim("GR86 RZ","3,990만원")]),
    CarModel(name:"GR Supra", price:"₩7,990만~", tagline:"레전드의 귀환", hp:387, torque:50, z100:4.3, topSpeed:250, fuel:"가솔린 터보", drive:"RWD", exteriorKeyword:"Toyota GR Supra exterior", interiorKeyword:"Toyota Supra interior cockpit", trims:[CarTrim("GR Supra 3.0","7,990만원"),CarTrim("GR Supra A91-MT","8,790만원")]),
    CarModel(name:"GR Yaris", price:"₩4,900만~", tagline:"WRC DNA 핫해치", hp:280, torque:40, z100:5.5, topSpeed:230, fuel:"가솔린 터보", drive:"AWD", exteriorKeyword:"Toyota GR Yaris exterior", interiorKeyword:"Toyota GR Yaris interior", trims:[CarTrim("GR Yaris 서킷","4,900만원"),CarTrim("GR Yaris 모리조","5,900만원")]),
    CarModel(name:"Land Cruiser 300", price:"₩8,990만~", tagline:"오프로드 레전드", hp:415, torque:65, z100:6.7, topSpeed:210, fuel:"가솔린/디젤", drive:"4WD", exteriorKeyword:"Toyota Land Cruiser 300 exterior", interiorKeyword:"Toyota Land Cruiser 300 interior", trims:[CarTrim("GX","8,990만원"),CarTrim("ZX","11,500만원")]),
    CarModel(name:"RAV4 PHEV", price:"₩4,990만~", tagline:"글로벌 베스트셀러 SUV", hp:306, torque:40, z100:6.0, topSpeed:180, fuel:"플러그인 하이브리드", drive:"AWD", exteriorKeyword:"Toyota RAV4 PHEV exterior", interiorKeyword:"Toyota RAV4 interior", trims:[CarTrim("GX","4,990만원"),CarTrim("XLE 프리미엄","5,490만원")]),
    CarModel(name:"bZ4X", price:"₩5,490만~", tagline:"토요타 순수전기 SUV", hp:218, torque:33, z100:7.7, topSpeed:160, fuel:"순수 전기", drive:"FWD/AWD", exteriorKeyword:"Toyota bZ4X electric SUV exterior", interiorKeyword:"Toyota bZ4X interior", trims:[CarTrim("FWD","5,490만원"),CarTrim("AWD","5,990만원")]),
  ]),

  // ── Honda ─────────────────────────────────────────────────
  CarBrand(name: "Honda", colorValue: 0xFF639922, models: [
    CarModel(name:"Civic Type R", price:"₩5,490만~", tagline:"FF 최강의 핫해치", hp:329, torque:42, z100:5.4, topSpeed:275, fuel:"가솔린 터보", drive:"FWD", exteriorKeyword:"Honda Civic Type R exterior", interiorKeyword:"Honda Civic Type R interior", trims:[CarTrim("Type R","5,490만원")]),
    CarModel(name:"NSX Type S", price:"₩2억 8,000만~", tagline:"혼다 하이브리드 슈퍼카", hp:600, torque:66, z100:2.9, topSpeed:308, fuel:"플러그인 하이브리드", drive:"AWD", exteriorKeyword:"Honda NSX Type S exterior", interiorKeyword:"Honda NSX interior cockpit", trims:[CarTrim("NSX Type S","28,000만원")]),
    CarModel(name:"e:Ny1", price:"₩5,690만~", tagline:"혼다 첫 순수전기 SUV", hp:204, torque:31, z100:7.7, topSpeed:160, fuel:"순수 전기", drive:"FWD", exteriorKeyword:"Honda eNy1 electric SUV exterior", interiorKeyword:"Honda electric SUV interior", trims:[CarTrim("EX","5,690만원"),CarTrim("어드밴스드","6,190만원")]),
    CarModel(name:"CR-V e:PHEV", price:"₩4,590만~", tagline:"플러그인 하이브리드 SUV", hp:204, torque:32, z100:7.5, topSpeed:180, fuel:"플러그인 하이브리드", drive:"AWD", exteriorKeyword:"Honda CRV PHEV exterior", interiorKeyword:"Honda CRV interior", trims:[CarTrim("어드밴스드","4,590만원"),CarTrim("EX-Master","5,190만원")]),
    CarModel(name:"Accord", price:"₩3,890만~", tagline:"미드사이즈 세단의 기준", hp:204, torque:26, z100:7.0, topSpeed:185, fuel:"하이브리드", drive:"FWD", exteriorKeyword:"Honda Accord exterior", interiorKeyword:"Honda Accord interior", trims:[CarTrim("투어링","3,890만원"),CarTrim("스포츠","4,290만원")]),
    CarModel(name:"ZR-V", price:"₩3,490만~", tagline:"스포티 컴팩트 SUV", hp:177, torque:24, z100:8.5, topSpeed:180, fuel:"하이브리드", drive:"FWD/AWD", exteriorKeyword:"Honda ZRV exterior sport SUV", interiorKeyword:"Honda ZRV interior", trims:[CarTrim("어드밴스드","3,490만원"),CarTrim("EX-Master","3,990만원")]),
  ]),

  // ── Nissan ────────────────────────────────────────────────
  CarBrand(name: "Nissan", colorValue: 0xFF534AB7, models: [
    CarModel(name:"GT-R Nismo", price:"₩2억 4,800만~", tagline:"갓질라 최강 버전", hp:600, torque:66, z100:2.7, topSpeed:315, fuel:"가솔린 터보 V6", drive:"AWD", exteriorKeyword:"Nissan GTR Nismo exterior", interiorKeyword:"Nissan GTR interior cockpit", trims:[CarTrim("GT-R Premium","14,500만원"),CarTrim("GT-R Nismo","24,800만원")]),
    CarModel(name:"Z Nismo", price:"₩6,990만~", tagline:"Z카 전통의 부활", hp:420, torque:52, z100:4.1, topSpeed:250, fuel:"가솔린 터보 V6", drive:"RWD", exteriorKeyword:"Nissan Z Nismo exterior", interiorKeyword:"Nissan Z interior", trims:[CarTrim("Z Sport","5,490만원"),CarTrim("Z Nismo","6,990만원")]),
    CarModel(name:"Ariya", price:"₩5,990만~", tagline:"닛산 전기 SUV 플래그십", hp:394, torque:60, z100:5.1, topSpeed:200, fuel:"순수 전기", drive:"FWD/AWD", exteriorKeyword:"Nissan Ariya electric SUV exterior", interiorKeyword:"Nissan Ariya interior", trims:[CarTrim("2WD","5,990만원"),CarTrim("e-4ORCE AWD","6,790만원")]),
    CarModel(name:"Juke Nismo", price:"₩3,290만~", tagline:"컴팩트 SUV 핫모델", hp:218, torque:30, z100:6.5, topSpeed:210, fuel:"가솔린 터보", drive:"FWD", exteriorKeyword:"Nissan Juke Nismo exterior", interiorKeyword:"Nissan Juke Nismo interior", trims:[CarTrim("Juke Nismo","3,290만원")]),
    CarModel(name:"Pathfinder", price:"₩4,990만~", tagline:"3열 가족형 SUV", hp:284, torque:34, z100:7.5, topSpeed:190, fuel:"가솔린", drive:"FWD/AWD", exteriorKeyword:"Nissan Pathfinder exterior SUV", interiorKeyword:"Nissan Pathfinder interior 3 row", trims:[CarTrim("S","4,990만원"),CarTrim("플래티넘","5,990만원")]),
    CarModel(name:"Leaf e+", price:"₩4,290만~", tagline:"글로벌 베스트셀러 전기차", hp:218, torque:34, z100:6.5, topSpeed:157, fuel:"순수 전기", drive:"FWD", exteriorKeyword:"Nissan Leaf electric car exterior", interiorKeyword:"Nissan Leaf interior", trims:[CarTrim("40kWh","3,590만원"),CarTrim("62kWh e+","4,290만원")]),
  ]),

  // ── Jeep ──────────────────────────────────────────────────
  CarBrand(name: "Jeep", colorValue: 0xFF27500A, models: [
    CarModel(name:"Wrangler Rubicon", price:"₩7,490만~", tagline:"오프로드의 아이콘", hp:285, torque:35, z100:7.8, topSpeed:175, fuel:"가솔린/하이브리드", drive:"4WD", exteriorKeyword:"Jeep Wrangler Rubicon exterior offroad", interiorKeyword:"Jeep Wrangler interior", trims:[CarTrim("Wrangler Sport","5,290만원"),CarTrim("Wrangler Rubicon","7,490만원")]),
    CarModel(name:"Grand Cherokee L", price:"₩8,200만~", tagline:"7인승 럭셔리 SUV", hp:357, torque:47, z100:6.5, topSpeed:210, fuel:"가솔린/PHEV", drive:"AWD", exteriorKeyword:"Jeep Grand Cherokee L exterior", interiorKeyword:"Jeep Grand Cherokee interior luxury", trims:[CarTrim("Limited","8,200만원"),CarTrim("Summit","9,800만원"),CarTrim("SRT","11,500만원")]),
    CarModel(name:"Gladiator", price:"₩6,490만~", tagline:"픽업 + 오프로더 조합", hp:285, torque:35, z100:8.1, topSpeed:170, fuel:"가솔린", drive:"4WD", exteriorKeyword:"Jeep Gladiator pickup truck exterior", interiorKeyword:"Jeep Gladiator interior", trims:[CarTrim("Overland","6,490만원"),CarTrim("Rubicon","7,290만원")]),
    CarModel(name:"Avenger 4xe", price:"₩4,290만~", tagline:"소형 전기 SUV", hp:156, torque:27, z100:7.5, topSpeed:150, fuel:"플러그인 하이브리드", drive:"AWD", exteriorKeyword:"Jeep Avenger 4xe exterior", interiorKeyword:"Jeep Avenger interior", trims:[CarTrim("Avenger 4xe","4,290만원")]),
    CarModel(name:"Compass Trailhawk", price:"₩4,990만~", tagline:"도심형 오프로더", hp:180, torque:27, z100:8.0, topSpeed:185, fuel:"가솔린/PHEV", drive:"4WD", exteriorKeyword:"Jeep Compass Trailhawk exterior", interiorKeyword:"Jeep Compass interior", trims:[CarTrim("Trailhawk","4,990만원"),CarTrim("Trailhawk PHEV","5,490만원")]),
    CarModel(name:"Recon", price:"₩6,990만~", tagline:"전기 오프로더 신세대", hp:268, torque:45, z100:6.5, topSpeed:160, fuel:"순수 전기", drive:"4WD", exteriorKeyword:"Jeep Recon electric offroad exterior", interiorKeyword:"Jeep electric interior", trims:[CarTrim("Recon","6,990만원")]),
  ]),

  // ── Ford ──────────────────────────────────────────────────
  CarBrand(name: "Ford", colorValue: 0xFF0C3566, models: [
    CarModel(name:"Mustang GT500", price:"₩1억 1,500만~", tagline:"아메리칸 머슬의 정수", hp:760, torque:85, z100:3.3, topSpeed:290, fuel:"가솔린 슈퍼차저 V8", drive:"RWD", exteriorKeyword:"Ford Mustang Shelby GT500 exterior", interiorKeyword:"Ford Mustang interior cockpit", trims:[CarTrim("Shelby GT500","11,500만원"),CarTrim("GT500 Carbon","13,200만원")]),
    CarModel(name:"Mustang Dark Horse", price:"₩7,900만~", tagline:"고회전 5.0 V8 머슬", hp:500, torque:57, z100:4.0, topSpeed:270, fuel:"가솔린 V8", drive:"RWD", exteriorKeyword:"Ford Mustang Dark Horse exterior", interiorKeyword:"Ford Mustang Dark Horse interior", trims:[CarTrim("Dark Horse","7,900만원"),CarTrim("Dark Horse R","9,500만원")]),
    CarModel(name:"Bronco Raptor", price:"₩8,990만~", tagline:"극한의 오프로드 SUV", hp:418, torque:57, z100:6.1, topSpeed:190, fuel:"가솔린 터보", drive:"4WD", exteriorKeyword:"Ford Bronco Raptor exterior offroad", interiorKeyword:"Ford Bronco interior", trims:[CarTrim("Bronco Sport","4,990만원"),CarTrim("Bronco Raptor","8,990만원")]),
    CarModel(name:"F-150 Lightning", price:"₩7,290만~", tagline:"미국 픽업의 전기화", hp:580, torque:105, z100:4.5, topSpeed:170, fuel:"순수 전기", drive:"AWD", exteriorKeyword:"Ford F150 Lightning electric pickup exterior", interiorKeyword:"Ford F150 Lightning interior", trims:[CarTrim("Pro","5,490만원"),CarTrim("Lariat","7,290만원"),CarTrim("Platinum","9,990만원")]),
    CarModel(name:"Explorer ST", price:"₩6,990만~", tagline:"퍼포먼스 3열 SUV", hp:400, torque:54, z100:5.5, topSpeed:230, fuel:"가솔린 터보 V6", drive:"AWD", exteriorKeyword:"Ford Explorer ST exterior", interiorKeyword:"Ford Explorer interior 3 row", trims:[CarTrim("Explorer ST","6,990만원")]),
    CarModel(name:"Ranger Raptor", price:"₩7,490만~", tagline:"고성능 미드사이즈 픽업", hp:392, torque:58, z100:5.9, topSpeed:180, fuel:"가솔린 터보", drive:"4WD", exteriorKeyword:"Ford Ranger Raptor pickup exterior", interiorKeyword:"Ford Ranger Raptor interior", trims:[CarTrim("Ranger Raptor","7,490만원")]),
  ]),
];
