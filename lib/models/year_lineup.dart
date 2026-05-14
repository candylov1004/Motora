// ============================================================
// lib/models/year_lineup.dart
// 연도별 라인업 데이터 모델 + 전체 데이터
// ============================================================

class YearSpec {
  final int year;
  final String trim;          // 트림명
  final int hp;               // 출력
  final double torque;        // 토크
  final double z100;          // 0-100
  final int topSpeed;         // 최고속
  final String engine;        // 엔진
  final String transmission;  // 변속기
  final String drive;         // 구동
  final String price;         // 가격
  final List<String> changes; // 주요 변경사항
  final bool isFacelift;      // 페이스리프트 여부
  final bool isNewGen;        // 풀체인지 여부

  const YearSpec({
    required this.year,
    required this.trim,
    required this.hp,
    required this.torque,
    required this.z100,
    required this.topSpeed,
    required this.engine,
    required this.transmission,
    required this.drive,
    required this.price,
    required this.changes,
    this.isFacelift = false,
    this.isNewGen = false,
  });
}

class ModelLineup {
  final String brandName;
  final String modelName;
  final List<YearSpec> years;

  const ModelLineup({
    required this.brandName,
    required this.modelName,
    required this.years,
  });
}

// ── 전체 연도별 라인업 데이터 ──────────────────────────────
final List<ModelLineup> yearLineups = [

  // ── 현대 Sonata N Line ──────────────────────────────────
  ModelLineup(brandName: "현대", modelName: "Sonata N Line", years: [
    YearSpec(year: 2021, trim: "N Line 스탠다드",
      hp: 180, torque: 27, z100: 7.9, topSpeed: 220,
      engine: "2.0 가솔린 터보", transmission: "8단 DCT", drive: "FWD",
      price: "₩3,040만~",
      changes: ["8세대 소나타 기반 N Line 최초 출시", "N Line 전용 프론트·리어 범퍼", "18인치 N Line 전용 휠"],
      isNewGen: true),
    YearSpec(year: 2022, trim: "N Line 2.5T",
      hp: 290, torque: 40, z100: 5.1, topSpeed: 250,
      engine: "2.5 가솔린 터보", transmission: "8단 습식 DCT", drive: "FWD",
      price: "₩4,290만~",
      changes: ["2.5T 고성능 엔진 추가", "N 전용 버킷시트 옵션", "레드 브레이크 캘리퍼"],
      isNewGen: true),
    YearSpec(year: 2023, trim: "N Line 퍼포먼스",
      hp: 290, torque: 40, z100: 5.1, topSpeed: 250,
      engine: "2.5 가솔린 터보", transmission: "8단 습식 DCT", drive: "FWD",
      price: "₩4,890만~",
      changes: ["N Line 전용 19인치 휠 추가", "디지털 클러스터 업그레이드", "N 사운드 이퀄라이저 기본화"]),
    YearSpec(year: 2024, trim: "N Line 프리미엄",
      hp: 290, torque: 40, z100: 5.1, topSpeed: 250,
      engine: "2.5 가솔린 터보", transmission: "8단 습식 DCT", drive: "FWD",
      price: "₩5,290만~",
      changes: ["페이스리프트 - 신규 전면 디자인", "OTA 무선 업데이트 지원", "N 퍼포먼스 브레이크 기본화"],
      isFacelift: true),
  ]),

  // ── 현대 IONIQ 6 ────────────────────────────────────────
  ModelLineup(brandName: "현대", modelName: "IONIQ 6", years: [
    YearSpec(year: 2023, trim: "롱레인지 2WD",
      hp: 229, torque: 35, z100: 7.4, topSpeed: 185,
      engine: "77.4kWh 배터리", transmission: "단단 감속기", drive: "RWD",
      price: "₩5,200만~",
      changes: ["세계 최초 출시", "에어로다이내믹 Cd 0.21", "800V 초고속 충전"],
      isNewGen: true),
    YearSpec(year: 2023, trim: "롱레인지 AWD",
      hp: 320, torque: 61, z100: 5.1, topSpeed: 185,
      engine: "77.4kWh 배터리", transmission: "단단 감속기", drive: "AWD",
      price: "₩5,800만~",
      changes: ["듀얼모터 AWD 추가", "0→100 5.1초 달성", "V2L 기능 지원"]),
    YearSpec(year: 2024, trim: "2024년형 롱레인지",
      hp: 229, torque: 35, z100: 7.4, topSpeed: 185,
      engine: "77.4kWh 배터리", transmission: "단단 감속기", drive: "RWD",
      price: "₩5,190만~",
      changes: ["가격 인하 및 사양 조정", "Level 2+ 주행보조 업그레이드", "디지털 사이드미러 옵션 추가"],
      isFacelift: false),
  ]),

  // ── 기아 EV6 GT ─────────────────────────────────────────
  ModelLineup(brandName: "기아", modelName: "EV6 GT", years: [
    YearSpec(year: 2022, trim: "EV6 GT",
      hp: 585, torque: 74, z100: 3.5, topSpeed: 260,
      engine: "77.4kWh 듀얼모터", transmission: "단단 감속기", drive: "AWD",
      price: "₩7,490만~",
      changes: ["EV6 라인업 최고 성능 모델 출시", "GT 전용 브레이크 & 서스펜션", "드리프트 모드 탑재"],
      isNewGen: true),
    YearSpec(year: 2023, trim: "EV6 GT (2023)",
      hp: 585, torque: 74, z100: 3.5, topSpeed: 260,
      engine: "77.4kWh 듀얼모터", transmission: "단단 감속기", drive: "AWD",
      price: "₩7,490만~",
      changes: ["GT 전용 버킷시트 기본화", "소프트웨어 업데이트", "GT 전용 20인치 휠 색상 추가"]),
    YearSpec(year: 2024, trim: "EV6 GT (페이스리프트)",
      hp: 641, torque: 75, z100: 3.4, topSpeed: 260,
      engine: "84kWh 듀얼모터", transmission: "단단 감속기", drive: "AWD",
      price: "₩7,790만~",
      changes: ["배터리 84kWh로 증가", "최고출력 641마력으로 향상", "전면 디자인 변경", "V2L 용량 증가"],
      isFacelift: true),
  ]),

  // ── BMW M4 Competition ──────────────────────────────────
  ModelLineup(brandName: "BMW", modelName: "M4 Competition", years: [
    YearSpec(year: 2021, trim: "M4 Competition (G82)",
      hp: 510, torque: 66, z100: 3.9, topSpeed: 290,
      engine: "S58 3.0 트윈터보 직6", transmission: "8단 M Steptronic", drive: "RWD",
      price: "₩1억 890만~",
      changes: ["G82 신형 출시 - 논란의 대형 키드니 그릴", "카본 루프 옵션", "M xDrive 옵션 추가"],
      isNewGen: true),
    YearSpec(year: 2022, trim: "M4 Competition xDrive",
      hp: 510, torque: 66, z100: 3.5, topSpeed: 290,
      engine: "S58 3.0 트윈터보 직6", transmission: "8단 M Steptronic", drive: "AWD",
      price: "₩1억 1,200만~",
      changes: ["M xDrive AWD 정식 추가", "0-100 3.5초로 단축", "M Drift Analyzer 기능"]),
    YearSpec(year: 2023, trim: "M4 CS",
      hp: 550, torque: 67, z100: 3.4, topSpeed: 302,
      engine: "S58 3.0 트윈터보 직6", transmission: "8단 M Steptronic", drive: "RWD",
      price: "₩1억 7,500만~",
      changes: ["M4 CS 한정판 출시", "카본 에어로 패키지", "경량 버킷시트 기본화"]),
    YearSpec(year: 2024, trim: "M4 Competition (LCI)",
      hp: 510, torque: 66, z100: 3.9, topSpeed: 290,
      engine: "S58 3.0 트윈터보 직6", transmission: "8단 M Steptronic", drive: "RWD/AWD",
      price: "₩1억 1,200만~",
      changes: ["LCI 페이스리프트 - 헤드라이트 변경", "iDrive 8.5 업그레이드", "M Drive Professional 기본화"],
      isFacelift: true),
  ]),

  // ── Tesla Model 3 ───────────────────────────────────────
  ModelLineup(brandName: "Tesla", modelName: "Model 3", years: [
    YearSpec(year: 2021, trim: "롱레인지 AWD",
      hp: 351, torque: 50, z100: 4.4, topSpeed: 225,
      engine: "듀얼모터 전기", transmission: "단단 감속기", drive: "AWD",
      price: "₩6,479만~",
      changes: ["HEPA 필터 옵션 추가", "내장 블랙앤화이트 신규 옵션", "탈착식 USB-C 허브"]),
    YearSpec(year: 2022, trim: "퍼포먼스",
      hp: 450, torque: 62, z100: 3.3, topSpeed: 261,
      engine: "듀얼모터 전기", transmission: "단단 감속기", drive: "AWD",
      price: "₩7,999만~",
      changes: ["퍼포먼스 부스트 소프트웨어 업데이트", "트랙 모드 V3 업그레이드"]),
    YearSpec(year: 2024, trim: "하이랜드 (신형)",
      hp: 358, torque: 53, z100: 4.4, topSpeed: 225,
      engine: "듀얼모터 전기", transmission: "단단 감속기", drive: "AWD",
      price: "₩5,999만~",
      changes: ["Model 3 Highland 풀체인지", "전면·후면 완전 변경", "앰비언트 라이트 추가",
        "뒷좌석 디스플레이 추가", "소음 대폭 감소"],
      isNewGen: true),
  ]),

  // ── Porsche 911 GT3 ─────────────────────────────────────
  ModelLineup(brandName: "Porsche", modelName: "911 GT3", years: [
    YearSpec(year: 2021, trim: "911 GT3 (992)",
      hp: 510, torque: 47, z100: 3.4, topSpeed: 318,
      engine: "4.0 NA 수평대향 6기통", transmission: "7단 PDK / 6단 수동", drive: "RWD",
      price: "₩2억 2,500만~",
      changes: ["992 세대 GT3 출시", "4.0L 자연흡기 9000rpm", "더블 위시본 서스펜션"],
      isNewGen: true),
    YearSpec(year: 2022, trim: "911 GT3 RS",
      hp: 525, torque: 47, z100: 3.2, topSpeed: 296,
      engine: "4.0 NA 수평대향 6기통", transmission: "7단 PDK", drive: "RWD",
      price: "₩3억 1,500만~",
      changes: ["GT3 RS 출시 - 최고 다운포스", "DRS 시스템 최초 적용", "750kg 다운포스 달성"]),
    YearSpec(year: 2023, trim: "911 GT3 투어링",
      hp: 510, torque: 47, z100: 3.4, topSpeed: 318,
      engine: "4.0 NA 수평대향 6기통", transmission: "6단 수동", drive: "RWD",
      price: "₩2억 3,800만~",
      changes: ["GT3 투어링 패키지 추가", "윙 제거 심플 디자인", "수동변속기 선택 가능"]),
    YearSpec(year: 2024, trim: "911 GT3 (2024)",
      hp: 510, torque: 47, z100: 3.4, topSpeed: 318,
      engine: "4.0 NA 수평대향 6기통", transmission: "7단 PDK / 6단 수동", drive: "RWD",
      price: "₩2억 3,800만~",
      changes: ["PCCB 세라믹 브레이크 옵션 업데이트", "새 컬러 추가", "소프트웨어 업데이트"]),
  ]),

  // ── Ferrari SF90 Stradale ───────────────────────────────
  ModelLineup(brandName: "Ferrari", modelName: "SF90 Stradale", years: [
    YearSpec(year: 2020, trim: "SF90 Stradale",
      hp: 1000, torque: 80, z100: 2.5, topSpeed: 340,
      engine: "V8 트윈터보 + 전기모터 3개", transmission: "8단 DCT", drive: "AWD",
      price: "₩4억 8,000만~",
      changes: ["Ferrari 최초 양산형 PHEV", "1000마력 최초 달성", "전기만으로 25km 주행"],
      isNewGen: true),
    YearSpec(year: 2021, trim: "SF90 Spider",
      hp: 1000, torque: 80, z100: 2.5, topSpeed: 340,
      engine: "V8 트윈터보 + 전기모터 3개", transmission: "8단 DCT", drive: "AWD",
      price: "₩5억 4,000만~",
      changes: ["SF90 오픈탑 Spider 추가", "전동 접이식 하드탑", "무게 증가 최소화 설계"]),
    YearSpec(year: 2023, trim: "SF90 XX Stradale",
      hp: 1030, torque: 81, z100: 2.3, topSpeed: 320,
      engine: "V8 트윈터보 + 전기모터 3개", transmission: "8단 DCT", drive: "AWD",
      price: "₩7억 5,000만~",
      changes: ["SF90 XX 한정판 출시", "카본파이버 익스테리어", "다운포스 490kg", "서킷 전용 세팅"]),
    YearSpec(year: 2024, trim: "SF90 Stradale (현행)",
      hp: 1000, torque: 80, z100: 2.5, topSpeed: 340,
      engine: "V8 트윈터보 + 전기모터 3개", transmission: "8단 DCT", drive: "AWD",
      price: "₩5억 6,000만~",
      changes: ["소프트웨어 업데이트", "신규 색상 추가", "인테리어 옵션 확대"]),
  ]),

  // ── Mercedes S-Class ────────────────────────────────────
  ModelLineup(brandName: "Mercedes", modelName: "S-Class", years: [
    YearSpec(year: 2021, trim: "S450 4MATIC",
      hp: 367, torque: 50, z100: 4.9, topSpeed: 250,
      engine: "3.0 직6 터보 + 마일드하이브리드", transmission: "9단 자동", drive: "4MATIC",
      price: "₩1억 6,000만~",
      changes: ["W223 7세대 출시", "최대 56인치 MBUX 하이퍼스크린", "후축 조향 시스템"],
      isNewGen: true),
    YearSpec(year: 2022, trim: "S580 4MATIC",
      hp: 503, torque: 71, z100: 4.3, topSpeed: 250,
      engine: "4.0 V8 트윈터보 + 마일드하이브리드", transmission: "9단 자동", drive: "4MATIC",
      price: "₩2억 500만~",
      changes: ["V8 S580 모델 추가", "마사지 시트 9개 포인트", "증강현실 HUD"]),
    YearSpec(year: 2023, trim: "Maybach S680",
      hp: 612, torque: 91, z100: 4.5, topSpeed: 250,
      engine: "6.0 V12 트윈터보", transmission: "9단 자동", drive: "4MATIC",
      price: "₩3억 7,000만~",
      changes: ["Maybach 최상위 S680 추가", "V12 마지막 양산차", "4D 마사지 시트"]),
    YearSpec(year: 2024, trim: "S450 4MATIC (LCI)",
      hp: 381, torque: 51, z100: 4.9, topSpeed: 250,
      engine: "3.0 직6 터보 + 마일드하이브리드", transmission: "9단 자동", drive: "4MATIC",
      price: "₩1억 7,000만~",
      changes: ["페이스리프트 - MBUX 업그레이드", "Level 3 자율주행 준비", "신규 헤드라이트"],
      isFacelift: true),
  ]),

  // ── Toyota GR86 ─────────────────────────────────────────
  ModelLineup(brandName: "Toyota", modelName: "GR86", years: [
    YearSpec(year: 2021, trim: "GR86 (초대)",
      hp: 197, torque: 20, z100: 7.0, topSpeed: 216,
      engine: "2.0 NA 수평대향 4기통", transmission: "6단 수동/자동", drive: "RWD",
      price: "₩2,990만~",
      changes: ["초대 86 출시 (토요타/스바루 공동개발)", "FR 스포츠 쿠페 컨셉", "레드라인 7400rpm"],
      isNewGen: true),
    YearSpec(year: 2022, trim: "GR86 (2세대)",
      hp: 234, torque: 25, z100: 6.3, topSpeed: 226,
      engine: "2.4 NA 수평대향 4기통", transmission: "6단 수동/자동", drive: "RWD",
      price: "₩3,490만~",
      changes: ["2세대 풀체인지 - 배기량 2.4L 증가", "출력 234마력으로 향상", "토크 25% 향상",
        "차체 강성 50% 향상"],
      isNewGen: true),
    YearSpec(year: 2023, trim: "GR86 Premium",
      hp: 234, torque: 25, z100: 6.3, topSpeed: 226,
      engine: "2.4 NA 수평대향 4기통", transmission: "6단 수동/자동", drive: "RWD",
      price: "₩3,790만~",
      changes: ["프리미엄 트림 추가", "레카로 시트 기본화", "브렘보 브레이크 옵션"]),
    YearSpec(year: 2024, trim: "GR86 RZ",
      hp: 234, torque: 25, z100: 6.3, topSpeed: 226,
      engine: "2.4 NA 수평대향 4기통", transmission: "6단 수동", drive: "RWD",
      price: "₩3,990만~",
      changes: ["RZ 최상위 트림 추가", "TRD 에어로 파츠 기본", "수동변속기 전용"]),
  ]),
];

/// 브랜드명 + 모델명으로 라인업 데이터 검색
ModelLineup? findLineup(String brandName, String modelName) {
  try {
    return yearLineups.firstWhere(
      (l) => l.brandName == brandName && l.modelName == modelName,
    );
  } catch (_) {
    return null;
  }
}
