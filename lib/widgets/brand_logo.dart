// ============================================================
// lib/widgets/brand_logo.dart
// 브랜드 로고 - 직접 제작한 심볼 (저작권 문제 없음)
// ============================================================

import 'package:flutter/material.dart';
import 'dart:math' as math;

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
      width: size,
      height: size,
      child: CustomPaint(
        painter: _BrandLogoPainter(
          brandName: brandName,
          logoColor: color ?? _defaultColor(brandName),
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
  final Color logoColor;

  _BrandLogoPainter({required this.brandName, required this.logoColor});

  // paint() 파라미터의 size를 사용 (클래스 필드 X)
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;
    final center = Offset(cx, cy);

    switch (brandName) {
      case "현대": _drawHyundai(canvas, w, h, center); break;
      case "기아": _drawKia(canvas, w, h, center); break;
      case "Genesis": _drawGenesis(canvas, w, h, center); break;
      case "BMW": _drawBMW(canvas, w, h, center); break;
      case "Mercedes": _drawMercedes(canvas, w, h, center); break;
      case "Audi": _drawAudi(canvas, w, h, center); break;
      case "Porsche": _drawPorsche(canvas, w, h, center); break;
      case "Ferrari": _drawFerrari(canvas, w, h, center); break;
      case "Lamborghini": _drawLamborghini(canvas, w, h, center); break;
      case "Volvo": _drawVolvo(canvas, w, h, center); break;
      case "Tesla": _drawTesla(canvas, w, h, center); break;
      case "Toyota": _drawToyota(canvas, w, h, center); break;
      case "Honda": _drawHonda(canvas, w, h, center); break;
      case "Nissan": _drawNissan(canvas, w, h, center); break;
      case "Jeep": _drawJeep(canvas, w, h, center); break;
      case "Ford": _drawFord(canvas, w, h, center); break;
      default: _drawDefault(canvas, w, h, center); break;
    }
  }

  Paint _stroke(double w) => Paint()
    ..color = logoColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = w * 0.09
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  Paint get _fill => Paint()
    ..color = logoColor
    ..style = PaintingStyle.fill;

  void _drawLetter(Canvas canvas, String letter, Offset pos, double w) {
    final tp = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(
          color: logoColor,
          fontSize: w * 0.38,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
  }

  // ── 현대: 타원 안 H ────────────────────────────────────
  void _drawHyundai(Canvas canvas, double w, double h, Offset c) {
    final p = _stroke(w);
    canvas.drawOval(Rect.fromCenter(center: c, width: w * 0.9, height: h * 0.65), p);
    final path = Path()
      ..moveTo(w * 0.3, h * 0.28)
      ..lineTo(w * 0.34, h * 0.72)
      ..moveTo(w * 0.66, h * 0.28)
      ..lineTo(w * 0.70, h * 0.72)
      ..moveTo(w * 0.32, h * 0.5)
      ..lineTo(w * 0.68, h * 0.5);
    canvas.drawPath(path, p..strokeWidth = w * 0.07);
  }

  // ── 기아: 원 + KIA ─────────────────────────────────────
  void _drawKia(Canvas canvas, double w, double h, Offset c) {
    canvas.drawCircle(c, w * 0.44, _stroke(w));
    _drawLetter(canvas, 'K', Offset(w * 0.25, h * 0.5), w);
    _drawLetter(canvas, 'I', Offset(w * 0.5, h * 0.5), w);
    _drawLetter(canvas, 'A', Offset(w * 0.75, h * 0.5), w);
  }

  // ── Genesis: 날개 심볼 ─────────────────────────────────
  void _drawGenesis(Canvas canvas, double w, double h, Offset c) {
    final p = _stroke(w)..strokeWidth = w * 0.07;
    final path = Path()
      ..moveTo(w * 0.5, h * 0.18)
      ..cubicTo(w * 0.12, h * 0.18, w * 0.06, h * 0.5, w * 0.2, h * 0.76)
      ..moveTo(w * 0.5, h * 0.18)
      ..cubicTo(w * 0.88, h * 0.18, w * 0.94, h * 0.5, w * 0.8, h * 0.76)
      ..moveTo(w * 0.5, h * 0.18)
      ..lineTo(w * 0.5, h * 0.82);
    canvas.drawPath(path, p);
    canvas.drawCircle(c, w * 0.07, _fill);
  }

  // ── BMW: 4분할 원 ──────────────────────────────────────
  void _drawBMW(Canvas canvas, double w, double h, Offset c) {
    final r = w * 0.44;
    final p = _stroke(w)..strokeWidth = w * 0.08;
    // 외곽 링
    canvas.drawCircle(c, r, p);
    // 내부 채우기 (좌상, 우하)
    final clipPath = Path()
      ..addOval(Rect.fromCircle(center: c, radius: r * 0.82));
    canvas.save();
    canvas.clipPath(clipPath);
    canvas.drawRect(Rect.fromLTWH(0, 0, w / 2, h / 2),
        _fill..color = logoColor.withOpacity(0.25));
    canvas.drawRect(Rect.fromLTWH(w / 2, h / 2, w / 2, h / 2),
        _fill..color = logoColor.withOpacity(0.25));
    canvas.restore();
    // 십자선
    canvas.drawLine(Offset(c.dx, c.dy - r * 0.82), Offset(c.dx, c.dy + r * 0.82),
        p..strokeWidth = w * 0.06);
    canvas.drawLine(Offset(c.dx - r * 0.82, c.dy), Offset(c.dx + r * 0.82, c.dy),
        p..strokeWidth = w * 0.06);
  }

  // ── Mercedes: 삼각별 ───────────────────────────────────
  void _drawMercedes(Canvas canvas, double w, double h, Offset c) {
    final r = w * 0.44;
    final p = _stroke(w)..strokeWidth = w * 0.07;
    canvas.drawCircle(c, r, p);
    for (int i = 0; i < 3; i++) {
      final angle = (i * 120 - 90) * math.pi / 180;
      canvas.drawLine(c,
        Offset(c.dx + r * 0.78 * math.cos(angle), c.dy + r * 0.78 * math.sin(angle)), p);
    }
    canvas.drawCircle(c, w * 0.06, _fill);
  }

  // ── Audi: 4링 ─────────────────────────────────────────
  void _drawAudi(Canvas canvas, double w, double h, Offset c) {
    final r = w * 0.15;
    final p = _stroke(w)..strokeWidth = w * 0.07;
    for (int i = 0; i < 4; i++) {
      canvas.drawCircle(Offset(w * 0.14 + i * r * 1.55, h * 0.5), r, p);
    }
  }

  // ── Porsche: 방패 ──────────────────────────────────────
  void _drawPorsche(Canvas canvas, double w, double h, Offset c) {
    final path = Path()
      ..moveTo(w * 0.5, h * 0.08)
      ..lineTo(w * 0.92, h * 0.3)
      ..lineTo(w * 0.92, h * 0.65)
      ..lineTo(w * 0.5, h * 0.92)
      ..lineTo(w * 0.08, h * 0.65)
      ..lineTo(w * 0.08, h * 0.3)
      ..close();
    canvas.drawPath(path, _stroke(w)..strokeWidth = w * 0.07);
    canvas.drawCircle(c, w * 0.12, _fill);
  }

  // ── Ferrari: 방패 ──────────────────────────────────────
  void _drawFerrari(Canvas canvas, double w, double h, Offset c) {
    final path = Path()
      ..moveTo(w * 0.5, h * 0.05)
      ..lineTo(w * 0.95, h * 0.25)
      ..lineTo(w * 0.95, h * 0.7)
      ..quadraticBezierTo(w * 0.5, h * 1.0, w * 0.05, h * 0.7)
      ..lineTo(w * 0.05, h * 0.25)
      ..close();
    canvas.drawPath(path, _stroke(w)..strokeWidth = w * 0.07);
    canvas.drawRect(
        Rect.fromCenter(center: Offset(c.dx, h * 0.55), width: w * 0.25, height: h * 0.22),
        _fill);
    final tp = Path()
      ..moveTo(c.dx, h * 0.28)
      ..lineTo(c.dx - w * 0.13, h * 0.45)
      ..lineTo(c.dx + w * 0.13, h * 0.45)
      ..close();
    canvas.drawPath(tp, _fill);
  }

  // ── Lamborghini: 방패+황소 ─────────────────────────────
  void _drawLamborghini(Canvas canvas, double w, double h, Offset c) {
    final path = Path()
      ..moveTo(w * 0.5, h * 0.05)
      ..lineTo(w * 0.95, h * 0.3)
      ..lineTo(w * 0.95, h * 0.75)
      ..lineTo(w * 0.5, h * 0.95)
      ..lineTo(w * 0.05, h * 0.75)
      ..lineTo(w * 0.05, h * 0.3)
      ..close();
    canvas.drawPath(path, _stroke(w)..strokeWidth = w * 0.07);
    final hp = Path()
      ..moveTo(c.dx - w * 0.15, h * 0.42)
      ..cubicTo(c.dx - w * 0.3, h * 0.2, c.dx - w * 0.1, h * 0.18, c.dx, h * 0.38)
      ..cubicTo(c.dx + w * 0.1, h * 0.18, c.dx + w * 0.3, h * 0.2, c.dx + w * 0.15, h * 0.42);
    canvas.drawPath(hp, _stroke(w)..strokeWidth = w * 0.07);
    canvas.drawCircle(c, w * 0.1, _fill);
  }

  // ── Volvo: 원 + 화살표 ─────────────────────────────────
  void _drawVolvo(Canvas canvas, double w, double h, Offset c) {
    final p = _stroke(w)..strokeWidth = w * 0.08;
    canvas.drawCircle(c, w * 0.37, p);
    canvas.drawLine(Offset(w * 0.62, h * 0.38), Offset(w * 0.88, h * 0.12), p);
    final ap = Path()
      ..moveTo(w * 0.72, h * 0.12)
      ..lineTo(w * 0.88, h * 0.12)
      ..lineTo(w * 0.88, h * 0.28);
    canvas.drawPath(ap, p);
  }

  // ── Tesla: T 심볼 ──────────────────────────────────────
  void _drawTesla(Canvas canvas, double w, double h, Offset c) {
    final p = _stroke(w)..strokeWidth = w * 0.08;
    final path = Path()
      ..moveTo(w * 0.15, h * 0.22)
      ..cubicTo(w * 0.15, h * 0.1, w * 0.85, h * 0.1, w * 0.85, h * 0.22)
      ..moveTo(w * 0.15, h * 0.22)
      ..lineTo(w * 0.35, h * 0.22)
      ..moveTo(w * 0.65, h * 0.22)
      ..lineTo(w * 0.85, h * 0.22)
      ..moveTo(w * 0.5, h * 0.15)
      ..lineTo(w * 0.5, h * 0.88);
    canvas.drawPath(path, p);
  }

  // ── Toyota: 3타원 ──────────────────────────────────────
  void _drawToyota(Canvas canvas, double w, double h, Offset c) {
    final p = _stroke(w)..strokeWidth = w * 0.07;
    canvas.drawOval(Rect.fromCenter(center: c, width: w * 0.32, height: h * 0.78), p);
    canvas.drawOval(Rect.fromCenter(center: c, width: w * 0.88, height: h * 0.46), p);
    canvas.drawOval(Rect.fromCenter(center: c, width: w * 0.92, height: h * 0.92), p);
  }

  // ── Honda: H 심볼 ──────────────────────────────────────
  void _drawHonda(Canvas canvas, double w, double h, Offset c) {
    final p = _stroke(w)..strokeWidth = w * 0.08;
    final path = Path()
      ..moveTo(w * 0.18, h * 0.25)
      ..lineTo(w * 0.18, h * 0.75)
      ..lineTo(w * 0.38, h * 0.75)
      ..lineTo(w * 0.38, h * 0.54)
      ..moveTo(w * 0.38, h * 0.54)
      ..lineTo(w * 0.62, h * 0.54)
      ..moveTo(w * 0.62, h * 0.54)
      ..lineTo(w * 0.62, h * 0.75)
      ..lineTo(w * 0.82, h * 0.75)
      ..lineTo(w * 0.82, h * 0.25);
    canvas.drawPath(path, p);
  }

  // ── Nissan: 원 + N ─────────────────────────────────────
  void _drawNissan(Canvas canvas, double w, double h, Offset c) {
    final p = _stroke(w)..strokeWidth = w * 0.08;
    canvas.drawCircle(c, w * 0.44, p);
    canvas.drawLine(Offset(w * 0.06, h * 0.5), Offset(w * 0.94, h * 0.5), p);
    _drawLetter(canvas, 'N', c, w);
  }

  // ── Jeep: 7슬롯 그릴 ──────────────────────────────────
  void _drawJeep(Canvas canvas, double w, double h, Offset c) {
    for (int i = 0; i < 7; i++) {
      final x = w * 0.06 + i * w * 0.132;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(x, h * 0.22, w * 0.09, h * 0.56),
            const Radius.circular(2)),
        _fill,
      );
    }
  }

  // ── Ford: 타원 + F ─────────────────────────────────────
  void _drawFord(Canvas canvas, double w, double h, Offset c) {
    canvas.drawOval(
        Rect.fromCenter(center: c, width: w * 0.95, height: h * 0.65),
        _stroke(w)..strokeWidth = w * 0.07);
    _drawLetter(canvas, 'F', c, w);
  }

  // ── 기본 ───────────────────────────────────────────────
  void _drawDefault(Canvas canvas, double w, double h, Offset c) {
    canvas.drawCircle(c, w * 0.44, _stroke(w)..strokeWidth = w * 0.07);
    _drawLetter(canvas, brandName.substring(0, 1), c, w);
  }

  @override
  bool shouldRepaint(_BrandLogoPainter old) =>
      old.brandName != brandName || old.logoColor != logoColor;
}
