// ============================================================
// lib/widgets/brand_logo.dart
// 브랜드 로고 - 직접 제작한 SVG 심볼 (저작권 문제 없음)
// 실제 로고와 유사하되 완전히 새로 디자인한 버전
// ============================================================

import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  final String brandName;
  final double size;
  final Color? color;

  const BrandLogo({
    super.key,
    required this.brandName,
    this.size = 32,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size, height: size,
      child: CustomPaint(
        painter: _BrandLogoPainter(
          brandName: brandName,
          color: color ?? _defaultColor(brandName),
        ),
      ),
    );
  }

  Color _defaultColor(String name) {
    switch (name) {
      case "현대": return const Color(0xFFE24B4A);
      case "기아": return const Color(0xFF185FA5);
      case "Genesis": return const Color(0xFF3C3489);
      case "BMW": return const Color(0xFF0C447C);
      case "Mercedes": return const Color(0xFF3B6D11);
      case "Audi": return const Color(0xFF5F5E5A);
      case "Porsche": return const Color(0xFF993C1D);
      case "Ferrari": return const Color(0xFFA32D2D);
      case "Lamborghini": return const Color(0xFFBA7517);
      case "Volvo": return const Color(0xFF085041);
      case "Tesla": return const Color(0xFFD85A30);
      case "Toyota": return const Color(0xFF854F0B);
      case "Honda": return const Color(0xFF639922);
      case "Nissan": return const Color(0xFF534AB7);
      case "Jeep": return const Color(0xFF27500A);
      case "Ford": return const Color(0xFF0C3566);
      default: return const Color(0xFF378ADD);
    }
  }
}

class _BrandLogoPainter extends CustomPainter {
  final String brandName;
  final Color color;
  _BrandLogoPainter({required this.brandName, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    switch (brandName) {
      case "현대": _drawHyundai(canvas, size); break;
      case "기아": _drawKia(canvas, size); break;
      case "Genesis": _drawGenesis(canvas, size); break;
      case "BMW": _drawBMW(canvas, size); break;
      case "Mercedes": _drawMercedes(canvas, size); break;
      case "Audi": _drawAudi(canvas, size); break;
      case "Porsche": _drawPorsche(canvas, size); break;
      case "Ferrari": _drawFerrari(canvas, size); break;
      case "Lamborghini": _drawLamborghini(canvas, size); break;
      case "Volvo": _drawVolvo(canvas, size); break;
      case "Tesla": _drawTesla(canvas, size); break;
      case "Toyota": _drawToyota(canvas, size); break;
      case "Honda": _drawHonda(canvas, size); break;
      case "Nissan": _drawNissan(canvas, size); break;
      case "Jeep": _drawJeep(canvas, size); break;
      case "Ford": _drawFord(canvas, size); break;
      default: _drawDefault(canvas, size); break;
    }
  }

  Paint get _stroke => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = size.width * 0.09
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  Paint get _fill => Paint()
    ..color = color
    ..style = PaintingStyle.fill;

  double get w => size.width;
  double get h => size.height;
  Offset get c => Offset(w / 2, h / 2);

  // ── 현대: H 심볼 (타원 안에 H) ─────────────────────────
  void _drawHyundai(Canvas canvas, Size size) {
    final p = _stroke;
    // 외곽 타원
    canvas.drawOval(Rect.fromCenter(center: c, width: w * 0.9, height: h * 0.65), p);
    // H 글자 (기울어진)
    final lx = w * 0.32, rx = w * 0.68;
    final ty = h * 0.28, by = h * 0.72;
    final my = h * 0.5;
    final lty = my - h * 0.04, lby = my + h * 0.04;
    final rty = my - h * 0.04, rby = my + h * 0.04;

    final path = Path();
    path.moveTo(lx - w * 0.04, ty);
    path.lineTo(lx + w * 0.04, by);
    path.moveTo(rx - w * 0.04, ty);
    path.lineTo(rx + w * 0.04, by);
    path.moveTo(lx + w * 0.01, lty + h * 0.02);
    path.lineTo(rx - w * 0.01, rby - h * 0.02);
    canvas.drawPath(path, p..strokeWidth = w * 0.07);
  }

  // ── 기아: KIA 텍스트 심볼 ──────────────────────────────
  void _drawKia(Canvas canvas, Size size) {
    // 원 배경
    canvas.drawCircle(c, w * 0.44, _fill..color = color.withOpacity(0.12));
    canvas.drawCircle(c, w * 0.44, _stroke..strokeWidth = w * 0.07);
    // K I A 이니셜
    _drawLetter(canvas, 'K', Offset(w * 0.22, h * 0.5));
    _drawLetter(canvas, 'I', Offset(w * 0.5, h * 0.5));
    _drawLetter(canvas, 'A', Offset(w * 0.78, h * 0.5));
  }

  void _drawLetter(Canvas canvas, String letter, Offset pos) {
    final tp = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(
          color: color,
          fontSize: w * 0.28,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
  }

  // ── Genesis: G 심볼 ────────────────────────────────────
  void _drawGenesis(Canvas canvas, Size size) {
    final p = _stroke..strokeWidth = w * 0.07;
    // 날개 형태 (G 변형)
    final path = Path();
    // 왼쪽 날개
    path.moveTo(w * 0.5, h * 0.2);
    path.cubicTo(w * 0.1, h * 0.2, w * 0.05, h * 0.5, w * 0.2, h * 0.75);
    // 오른쪽 날개
    path.moveTo(w * 0.5, h * 0.2);
    path.cubicTo(w * 0.9, h * 0.2, w * 0.95, h * 0.5, w * 0.8, h * 0.75);
    // 중앙 수직선
    path.moveTo(w * 0.5, h * 0.2);
    path.lineTo(w * 0.5, h * 0.8);
    canvas.drawPath(path, p);
    // 중앙 점
    canvas.drawCircle(c, w * 0.07, _fill);
  }

  // ── BMW: 4분할 원 ──────────────────────────────────────
  void _drawBMW(Canvas canvas, Size size) {
    final r = w * 0.44;
    // 외곽 링
    canvas.drawCircle(c, r, _stroke..strokeWidth = w * 0.08);
    // 내부 십자 구분선
    canvas.drawLine(Offset(c.dx, c.dy - r * 0.85),
        Offset(c.dx, c.dy + r * 0.85), _stroke..strokeWidth = w * 0.06);
    canvas.drawLine(Offset(c.dx - r * 0.85, c.dy),
        Offset(c.dx + r * 0.85, c.dy), _stroke..strokeWidth = w * 0.06);
    // 좌상단, 우하단 파란색 채우기
    final clipPath = Path()..addCircle(c.dx, c.dy, r * 0.82);
    canvas.save();
    canvas.clipPath(clipPath);
    canvas.drawRect(Rect.fromLTWH(0, 0, w / 2, h / 2),
        _fill..color = color.withOpacity(0.25));
    canvas.drawRect(Rect.fromLTWH(w / 2, h / 2, w / 2, h / 2),
        _fill..color = color.withOpacity(0.25));
    canvas.restore();
  }

  // ── Mercedes: 삼각별 ───────────────────────────────────
  void _drawMercedes(Canvas canvas, Size size) {
    final r = w * 0.44;
    canvas.drawCircle(c, r, _stroke..strokeWidth = w * 0.07);
    // 3방향 별
    final p = _stroke..strokeWidth = w * 0.07;
    for (int i = 0; i < 3; i++) {
      final angle = (i * 120 - 90) * 3.14159 / 180;
      canvas.drawLine(
        c,
        Offset(c.dx + r * 0.8 * cos(angle), c.dy + r * 0.8 * sin(angle)),
        p,
      );
    }
    canvas.drawCircle(c, w * 0.06, _fill);
  }

  double cos(double rad) => _cos(rad);
  double sin(double rad) => _sin(rad);

  double _cos(double x) {
    double result = 1, term = 1;
    for (int i = 1; i <= 10; i++) {
      term *= -x * x / (2 * i * (2 * i - 1));
      result += term;
    }
    return result;
  }

  double _sin(double x) {
    double result = x, term = x;
    for (int i = 1; i <= 10; i++) {
      term *= -x * x / ((2 * i + 1) * 2 * i);
      result += term;
    }
    return result;
  }

  // ── Audi: 4개 링 ──────────────────────────────────────
  void _drawAudi(Canvas canvas, Size size) {
    final r = w * 0.16;
    final p = _stroke..strokeWidth = w * 0.07;
    for (int i = 0; i < 4; i++) {
      canvas.drawCircle(
        Offset(w * 0.14 + i * r * 1.55, h * 0.5), r, p);
    }
  }

  // ── Porsche: 방패 심볼 ─────────────────────────────────
  void _drawPorsche(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(w * 0.5, h * 0.08);
    path.lineTo(w * 0.92, h * 0.3);
    path.lineTo(w * 0.92, h * 0.65);
    path.lineTo(w * 0.5, h * 0.92);
    path.lineTo(w * 0.08, h * 0.65);
    path.lineTo(w * 0.08, h * 0.3);
    path.close();
    canvas.drawPath(path, _stroke..strokeWidth = w * 0.07);
    // 중앙 말 (단순화)
    canvas.drawCircle(c, w * 0.12, _fill);
    final hp = Path();
    hp.moveTo(c.dx, c.dy - h * 0.16);
    hp.lineTo(c.dx - w * 0.08, c.dy);
    hp.lineTo(c.dx + w * 0.08, c.dy);
    hp.close();
    canvas.drawPath(hp, _fill);
  }

  // ── Ferrari: 방패 ─────────────────────────────────────
  void _drawFerrari(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(w * 0.5, h * 0.05);
    path.lineTo(w * 0.95, h * 0.25);
    path.lineTo(w * 0.95, h * 0.7);
    path.quadraticBezierTo(w * 0.5, h * 1.0, w * 0.05, h * 0.7);
    path.lineTo(w * 0.05, h * 0.25);
    path.close();
    canvas.drawPath(path, _stroke..strokeWidth = w * 0.07);
    // 황마 (단순화 - 사각형+삼각형)
    final hp = Paint()..color = color..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromCenter(center: Offset(c.dx, h * 0.55), width: w * 0.25, height: h * 0.22), hp);
    final tp = Path();
    tp.moveTo(c.dx, h * 0.28);
    tp.lineTo(c.dx - w * 0.13, h * 0.45);
    tp.lineTo(c.dx + w * 0.13, h * 0.45);
    tp.close();
    canvas.drawPath(tp, hp);
  }

  // ── Lamborghini: 황소 심볼 ─────────────────────────────
  void _drawLamborghini(Canvas canvas, Size size) {
    // 방패형
    final path = Path();
    path.moveTo(w * 0.5, h * 0.05);
    path.lineTo(w * 0.95, h * 0.3);
    path.lineTo(w * 0.95, h * 0.75);
    path.lineTo(w * 0.5, h * 0.95);
    path.lineTo(w * 0.05, h * 0.75);
    path.lineTo(w * 0.05, h * 0.3);
    path.close();
    canvas.drawPath(path, _stroke..strokeWidth = w * 0.07);
    // 황소 뿔 (단순화)
    final hp = Path();
    hp.moveTo(c.dx - w * 0.15, h * 0.42);
    hp.cubicTo(c.dx - w * 0.3, h * 0.2, c.dx - w * 0.1, h * 0.18, c.dx, h * 0.38);
    hp.cubicTo(c.dx + w * 0.1, h * 0.18, c.dx + w * 0.3, h * 0.2, c.dx + w * 0.15, h * 0.42);
    canvas.drawPath(hp, _stroke..strokeWidth = w * 0.07);
    canvas.drawCircle(c, w * 0.1, _fill);
  }

  // ── Volvo: 원 + 화살표 ─────────────────────────────────
  void _drawVolvo(Canvas canvas, Size size) {
    canvas.drawCircle(c, w * 0.37, _stroke..strokeWidth = w * 0.08);
    // 오른쪽 상단 화살표
    final p = _stroke..strokeWidth = w * 0.08;
    canvas.drawLine(
        Offset(w * 0.62, h * 0.38), Offset(w * 0.88, h * 0.12), p);
    final ap = Path();
    ap.moveTo(w * 0.72, h * 0.12);
    ap.lineTo(w * 0.88, h * 0.12);
    ap.lineTo(w * 0.88, h * 0.28);
    canvas.drawPath(ap, p);
  }

  // ── Tesla: T 심볼 ──────────────────────────────────────
  void _drawTesla(Canvas canvas, Size size) {
    final p = _stroke..strokeWidth = w * 0.08;
    // 상단 호
    final arcPath = Path();
    arcPath.moveTo(w * 0.15, h * 0.22);
    arcPath.cubicTo(w * 0.15, h * 0.1, w * 0.85, h * 0.1, w * 0.85, h * 0.22);
    // 날개
    arcPath.moveTo(w * 0.15, h * 0.22);
    arcPath.lineTo(w * 0.35, h * 0.22);
    arcPath.moveTo(w * 0.65, h * 0.22);
    arcPath.lineTo(w * 0.85, h * 0.22);
    // 수직선
    arcPath.moveTo(w * 0.5, h * 0.15);
    arcPath.lineTo(w * 0.5, h * 0.88);
    canvas.drawPath(arcPath, p);
  }

  // ── Toyota: 3개 타원 ───────────────────────────────────
  void _drawToyota(Canvas canvas, Size size) {
    final p = _stroke..strokeWidth = w * 0.07;
    // 수직 타원 (차체)
    canvas.drawOval(
        Rect.fromCenter(center: c, width: w * 0.32, height: h * 0.78), p);
    // 수평 타원 (날개)
    canvas.drawOval(
        Rect.fromCenter(center: c, width: w * 0.88, height: h * 0.46), p);
    // 외곽 타원
    canvas.drawOval(
        Rect.fromCenter(center: c, width: w * 0.92, height: h * 0.92), p);
  }

  // ── Honda: H 윙 심볼 ──────────────────────────────────
  void _drawHonda(Canvas canvas, Size size) {
    final p = _stroke..strokeWidth = w * 0.08;
    // H 형태 날개
    final path = Path();
    // 왼쪽 날개
    path.moveTo(w * 0.05, h * 0.3);
    path.lineTo(w * 0.05, h * 0.7);
    path.lineTo(w * 0.35, h * 0.7);
    path.lineTo(w * 0.35, h * 0.52);
    // 크로스바
    path.moveTo(w * 0.35, h * 0.52);
    path.lineTo(w * 0.65, h * 0.52);
    // 오른쪽 날개
    path.moveTo(w * 0.65, h * 0.52);
    path.lineTo(w * 0.65, h * 0.7);
    path.lineTo(w * 0.95, h * 0.7);
    path.lineTo(w * 0.95, h * 0.3);
    canvas.drawPath(path, p);
  }

  // ── Nissan: 가로 바 원형 ───────────────────────────────
  void _drawNissan(Canvas canvas, Size size) {
    final p = _stroke..strokeWidth = w * 0.08;
    canvas.drawCircle(c, w * 0.44, p);
    // 가로 바
    canvas.drawLine(
        Offset(w * 0.06, h * 0.5), Offset(w * 0.94, h * 0.5), p);
    // N 텍스트
    _drawLetter(canvas, 'N', c);
  }

  // ── Jeep: 7슬롯 그릴 ──────────────────────────────────
  void _drawJeep(Canvas canvas, Size size) {
    final p = _fill;
    // 7개 수직 슬롯 (지프 그릴 상징)
    for (int i = 0; i < 7; i++) {
      final x = w * 0.08 + i * w * 0.126;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, h * 0.22, w * 0.08, h * 0.56),
          const Radius.circular(2),
        ),
        p,
      );
    }
  }

  // ── Ford: 타원 F ──────────────────────────────────────
  void _drawFord(Canvas canvas, Size size) {
    canvas.drawOval(
        Rect.fromCenter(center: c, width: w * 0.95, height: h * 0.65),
        _stroke..strokeWidth = w * 0.07);
    _drawLetter(canvas, 'F', c);
  }

  // ── 기본: 브랜드 이니셜 ───────────────────────────────
  void _drawDefault(Canvas canvas, Size size) {
    canvas.drawCircle(c, w * 0.44, _stroke..strokeWidth = w * 0.07);
    _drawLetter(canvas, brandName.substring(0, 1), c);
  }

  @override
  bool shouldRepaint(_BrandLogoPainter old) =>
      old.brandName != brandName || old.color != color;
}
