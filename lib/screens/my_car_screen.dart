// ============================================================
// lib/screens/my_car_screen.dart
// 내 차 등록 및 관리 화면
// ============================================================

import 'package:flutter/material.dart';
import '../models/car_data.dart';
import '../services/storage_service.dart';

class MyCarScreen extends StatefulWidget {
  const MyCarScreen({super.key});
  @override
  State<MyCarScreen> createState() => _MyCarScreenState();
}

class _MyCarScreenState extends State<MyCarScreen> {
  List<MyCar> _myCars = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final cars = await StorageService.getMyCars();
    if (mounted) setState(() { _myCars = cars; _loading = false; });
  }

  Future<void> _delete(int i) async {
    await StorageService.removeMyCar(i);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("내 차",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E))),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded, color: Color(0xFF378ADD)),
            onPressed: () => _showAddDialog(context),
          ),
        ],
      ),
      body: _loading
        ? const Center(child: CircularProgressIndicator())
        : _myCars.isEmpty ? _buildEmpty(context) : _buildList(),
      floatingActionButton: _myCars.isNotEmpty ? FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        backgroundColor: const Color(0xFF378ADD),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ) : null,
    );
  }

  Widget _buildEmpty(BuildContext context) => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.directions_car_outlined, size: 72,
          color: Colors.grey.withOpacity(0.3)),
      const SizedBox(height: 16),
      const Text("등록된 차량이 없어요",
        style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6))),
      const SizedBox(height: 20),
      ElevatedButton.icon(
        onPressed: () => _showAddDialog(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF378ADD),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: const Icon(Icons.add_rounded),
        label: const Text("내 차 등록하기"),
      ),
    ]),
  );

  Widget _buildList() => ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: _myCars.length,
    itemBuilder: (context, i) {
      final car = _myCars[i];
      final brand = carBrands.firstWhere(
        (b) => b.name == car.brand, orElse: () => carBrands.first);
      final color = Color(brand.colorValue);

      return Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8ECF0)),
          boxShadow: const [BoxShadow(color: Color(0x0A000000),
              blurRadius: 8, offset: Offset(0, 3))]),
        child: Column(children: [
          // 상단 색상 바
          Container(height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)))),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(car.brand,
                    style: TextStyle(fontSize: 11, color: color,
                        fontWeight: FontWeight.w600)),
                  Text(car.model,
                    style: const TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
                  Text("${car.year}년형 · ${car.trim}",
                    style: const TextStyle(fontSize: 13, color: Color(0xFF8A94A6))),
                ])),
                // 차량 색상 표시
                Column(children: [
                  Container(width: 32, height: 32,
                    decoration: BoxDecoration(
                      color: _parseCarColor(car.color),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE8ECF0), width: 2),
                      boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 4)])),
                  const SizedBox(height: 4),
                  Text(car.color,
                    style: const TextStyle(fontSize: 10, color: Color(0xFF8A94A6))),
                ]),
              ]),
              if (car.memo.isNotEmpty) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FB),
                    borderRadius: BorderRadius.circular(8)),
                  child: Text(car.memo,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF5A6478)))),
              ],
              const SizedBox(height: 12),
              Row(children: [
                Text("등록일: ${car.registeredAt.year}.${car.registeredAt.month.toString().padLeft(2,'0')}.${car.registeredAt.day.toString().padLeft(2,'0')}",
                  style: const TextStyle(fontSize: 11, color: Color(0xFFBCC3CE))),
                const Spacer(),
                TextButton(
                  onPressed: () => _showDeleteDialog(context, i, car),
                  child: const Text("삭제", style: TextStyle(color: Colors.red, fontSize: 12)),
                ),
              ]),
            ]),
          ),
        ]),
      );
    },
  );

  Future<void> _showAddDialog(BuildContext context) async {
    String? selBrand;
    String? selModel;
    int selYear = DateTime.now().year;
    String selTrim = "";
    String selColor = "흰색";
    String memo = "";

    final colors = ["흰색", "검정", "실버", "회색", "빨강", "파랑", "초록", "노랑", "주황", "베이지"];

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            top: 20, left: 20, right: 20),
          child: SingleChildScrollView(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 핸들
              Center(child: Container(width: 40, height: 4,
                decoration: BoxDecoration(color: const Color(0xFFE8ECF0),
                    borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              const Text("내 차 등록",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
              const SizedBox(height: 20),

              // 브랜드 선택
              const Text("브랜드", style: TextStyle(fontSize: 13,
                  fontWeight: FontWeight.w600, color: Color(0xFF5A6478))),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selBrand,
                decoration: _inputDeco("브랜드 선택"),
                items: carBrands.map((b) => DropdownMenuItem(
                  value: b.name, child: Text(b.name))).toList(),
                onChanged: (v) => setModalState(() {
                  selBrand = v; selModel = null; selTrim = "";
                }),
              ),
              const SizedBox(height: 14),

              // 모델 선택
              const Text("모델", style: TextStyle(fontSize: 13,
                  fontWeight: FontWeight.w600, color: Color(0xFF5A6478))),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selModel,
                decoration: _inputDeco("모델 선택"),
                items: selBrand == null ? [] :
                  carBrands.firstWhere((b) => b.name == selBrand).models
                    .map((m) => DropdownMenuItem(value: m.name, child: Text(m.name)))
                    .toList(),
                onChanged: (v) => setModalState(() {
                  selModel = v;
                  if (v != null && selBrand != null) {
                    final brand = carBrands.firstWhere((b) => b.name == selBrand);
                    final model = brand.models.firstWhere((m) => m.name == v);
                    selTrim = model.trims.isNotEmpty ? model.trims.first.name : "";
                  }
                }),
              ),
              const SizedBox(height: 14),

              // 연도 + 트림
              Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("연도", style: TextStyle(fontSize: 13,
                      fontWeight: FontWeight.w600, color: Color(0xFF5A6478))),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    value: selYear,
                    decoration: _inputDeco("연도"),
                    items: List.generate(15, (i) => DateTime.now().year - i)
                      .map((y) => DropdownMenuItem(value: y, child: Text("$y년")))
                      .toList(),
                    onChanged: (v) => setModalState(() => selYear = v!),
                  ),
                ])),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("트림", style: TextStyle(fontSize: 13,
                      fontWeight: FontWeight.w600, color: Color(0xFF5A6478))),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selTrim.isEmpty ? null : selTrim,
                    decoration: _inputDeco("트림"),
                    items: selModel == null || selBrand == null ? [] :
                      carBrands.firstWhere((b) => b.name == selBrand)
                        .models.firstWhere((m) => m.name == selModel)
                        .trims.map((t) => DropdownMenuItem(
                          value: t.name, child: Text(t.name,
                          overflow: TextOverflow.ellipsis))).toList(),
                    onChanged: (v) => setModalState(() => selTrim = v ?? ""),
                  ),
                ])),
              ]),
              const SizedBox(height: 14),

              // 차량 색상
              const Text("차량 색상", style: TextStyle(fontSize: 13,
                  fontWeight: FontWeight.w600, color: Color(0xFF5A6478))),
              const SizedBox(height: 8),
              Wrap(spacing: 8, runSpacing: 8,
                children: colors.map((c) => GestureDetector(
                  onTap: () => setModalState(() => selColor = c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: selColor == c
                        ? const Color(0xFF378ADD) : const Color(0xFFF4F6FA),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selColor == c
                          ? const Color(0xFF378ADD) : const Color(0xFFE8ECF0))),
                    child: Text(c, style: TextStyle(fontSize: 12,
                      color: selColor == c ? Colors.white : const Color(0xFF5A6478))),
                  ))).toList(),
              ),
              const SizedBox(height: 14),

              // 메모
              const Text("메모 (선택)", style: TextStyle(fontSize: 13,
                  fontWeight: FontWeight.w600, color: Color(0xFF5A6478))),
              const SizedBox(height: 8),
              TextFormField(
                decoration: _inputDeco("예: 2023년 구매, 주행거리 25,000km"),
                maxLines: 2,
                onChanged: (v) => memo = v,
              ),
              const SizedBox(height: 24),

              // 등록 버튼
              SizedBox(width: double.infinity,
                child: ElevatedButton(
                  onPressed: selBrand == null || selModel == null ? null : () async {
                    await StorageService.addMyCar(MyCar(
                      brand: selBrand!,
                      model: selModel!,
                      year: selYear,
                      trim: selTrim,
                      color: selColor,
                      memo: memo,
                    ));
                    if (ctx.mounted) Navigator.pop(ctx);
                    _load();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF378ADD),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFE8ECF0),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text("등록하기",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                )),
            ],
          )),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext ctx, int i, MyCar car) async {
    final confirm = await showDialog<bool>(context: ctx,
      builder: (_) => AlertDialog(
        title: const Text("내 차 삭제"),
        content: Text("${car.model}을(를) 삭제할까요?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false),
            child: const Text("취소")),
          TextButton(onPressed: () => Navigator.pop(ctx, true),
            child: const Text("삭제", style: TextStyle(color: Colors.red))),
        ],
      ));
    if (confirm == true) _delete(i);
  }

  Color _parseCarColor(String name) {
    switch (name) {
      case "흰색": return Colors.white;
      case "검정": return Colors.black87;
      case "실버": return Colors.grey.shade400;
      case "회색": return Colors.grey.shade600;
      case "빨강": return Colors.red;
      case "파랑": return Colors.blue;
      case "초록": return Colors.green;
      case "노랑": return Colors.yellow;
      case "주황": return Colors.orange;
      case "베이지": return const Color(0xFFD4C5A9);
      default: return Colors.grey.shade300;
    }
  }

  InputDecoration _inputDeco(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Color(0xFFBCC3CE), fontSize: 13),
    filled: true,
    fillColor: const Color(0xFFF8F9FB),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFE8ECF0))),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFE8ECF0))),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF378ADD))),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  );
}
