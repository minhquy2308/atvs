import 'dart:convert';

import 'package:atvs/remote_service.dart';

ChiTietPhieu chiTietPhieuFromJson(String str) => ChiTietPhieu.fromJson(json.decode(str));

String chiTietPhieuToJson(ChiTietPhieu data) => json.encode(data.toJson());

class ChiTietPhieu {
  ChiTietPhieu({
    required this.id,
    required this.title,
    required this.khoitao,
    required this.kiemtra,
  });

  int id;
  String title;
  String khoitao;
  List<Kiemtra> kiemtra;

  factory ChiTietPhieu.fromJson(Map<String, dynamic> json) => ChiTietPhieu(
    id: json["id"],
    title: json["title"],
    khoitao: json["khoitao"],
    kiemtra: List<Kiemtra>.from(json["kiemtra"].map((x) => Kiemtra.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "khoitao": khoitao,
    "kiemtra": List<dynamic>.from(kiemtra.map((x) => x.toJson())),
  };
}

class Kiemtra {
  Kiemtra({
    required this.id,
    required this.diemDanhgia,
    required this.noidungId,
    required this.photo,
    required this.phieuId,
  });

  int id;
  String diemDanhgia;
  String noidungId;
  dynamic photo;
  String phieuId;

  factory Kiemtra.fromJson(Map<String, dynamic> json) => Kiemtra(
    id: json["id"],
    diemDanhgia: json["diem_danhgia"],
    noidungId: json["noidung_id"],
    photo: json["photo"],
    phieuId: json["phieu_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "diem_danhgia": diemDanhgia,
    "noidung_id": noidungId,
    "photo": photo,
    "phieu_id": phieuId,
  };
}
ChiTietPhieu? phieu;
getPhieu() async {
  phieu = (await RemoteServiceChiTietPhieu().getPhieu())!;
}