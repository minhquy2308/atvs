import 'dart:convert';

import 'package:atvs/remote_service.dart';

List<DiemChiTiet?>? diemChiTietFromJson(String str) => json.decode(str) == null ? [] : List<DiemChiTiet?>.from(json.decode(str)!.map((x) => DiemChiTiet.fromJson(x)));

String diemChiTietToJson(List<DiemChiTiet?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class DiemChiTiet {
  DiemChiTiet({
    required this.id,
    required this.diemchitiet,
    required this.diemdonvi,
    required this.diemtothamdinh,
    required this.danhmucId,
    required this.chitiettieuchiId,
    required this.userId,
    required this.donviId,
    required this.periodId,
    required this.note,
    required this.chitietnoidungId,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String? diemchitiet;
  String? diemdonvi;
  String? diemtothamdinh;
  String? danhmucId;
  String? chitiettieuchiId;
  String? userId;
  String? donviId;
  String? periodId;
  dynamic note;
  String? chitietnoidungId;
  String? photo;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DiemChiTiet.fromJson(Map<String, dynamic> json) => DiemChiTiet(
    id: json["id"],
    diemchitiet: json["diemchitiet"],
    diemdonvi: json["diemdonvi"],
    diemtothamdinh: json["diemtothamdinh"],
    danhmucId: json["danhmuc_id"],
    chitiettieuchiId: json["chitiettieuchi_id"],
    userId: json["user_id"],
    donviId: json["donvi_id"],
    periodId: json["period_id"],
    note: json["note"],
    chitietnoidungId: json["chitietnoidung_id"],
    photo: json["photo"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "diemchitiet": diemchitiet,
    "diemdonvi": diemdonvi,
    "diemtothamdinh": diemtothamdinh,
    "danhmuc_id": danhmucId,
    "chitiettieuchi_id": chitiettieuchiId,
    "user_id": userId,
    "donvi_id": donviId,
    "period_id": periodId,
    "note": note,
    "chitietnoidung_id": chitietnoidungId,
    "photo": photo,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
List<DiemChiTiet>? diemchitiets;
getDiemChiTiet(String donvi, String ky) async {
  diemchitiets = (await RemoteServiceDiemChiTiet().getDiemChiTiet(donvi, ky))!.cast<DiemChiTiet>();
}