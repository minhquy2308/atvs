// To parse this JSON data, do
//
//     final empty = emptyFromJson(jsonString);

import 'dart:convert';

List<Thang> baocaoFromJson(String str) => List<Thang>.from(json.decode(str).map((x) => Thang.fromJson(x)));

String baocaoToJson(List<Thang> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Thang {
  Thang({
    required this.month,
    required this.data,
    required this.chuaDanhgia,
  });

  int month;
  List<Data> data;
  String? chuaDanhgia;

  factory Thang.fromJson(Map<String, dynamic> json) => Thang(
    month: json["month"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    chuaDanhgia: json["chua_danhgia"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "chua_danhgia": chuaDanhgia,
  };
}

class Data {
  Data({
    required this.donviId,
    required this.tenDonvi,
    required this.idKy,
    required this.thang,
    required this.nam,
    required this.sumDiemdonvi,
    required this.sumDiemtothamdinh,
    required this.chuaDanhgia,
  });

  String donviId;
  String tenDonvi;
  String idKy;
  String thang;
  String nam;
  String? sumDiemdonvi;
  String? sumDiemtothamdinh;
  String? chuaDanhgia;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    donviId: json["donvi_id"],
    tenDonvi: json["ten_donvi"],
    idKy: json["id_ky"],
    thang: json["thang"],
    nam: json["nam"],
    sumDiemdonvi: json["sum_diemdonvi"],
    sumDiemtothamdinh: json["sum_diemtothamdinh"],
    chuaDanhgia: json["chua_danhgia"],
  );

  Map<String, dynamic> toJson() => {
    "donvi_id": donviId,
    "ten_donvi": tenDonvi,
    "id_ky": idKy,
    "thang": thang,
    "nam": nam,
    "sum_diemdonvi": sumDiemdonvi,
    "sum_diemtothamdinh": sumDiemtothamdinh,
    "chua_danhgia": chuaDanhgia,
  };
}
