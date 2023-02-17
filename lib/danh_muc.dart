// To parse this JSON data, do
//
//     final danhMuc = danhMucFromJson(jsonString);

import 'dart:convert';

import 'package:atvs/remote_service.dart';

List<DanhMuc?>? danhMucFromJson(String str) => json.decode(str) == null ? [] : List<DanhMuc?>.from(json.decode(str)!.map((x) => DanhMuc.fromJson(x)));

String danhMucToJson(List<DanhMuc?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class DanhMuc {
  DanhMuc({
    required this.id,
    required this.tenDm,
    required this.sothutu,

  });

  int? id;
  String? tenDm;
  String? sothutu;

  factory DanhMuc.fromJson(Map<String, dynamic> json) => DanhMuc(
    id: json["id"],
    tenDm: json["ten_dm"],
    sothutu: json["sothutu"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ten_dm": tenDm,
    "sothutu": sothutu,
  };
}
List<DanhMuc>? danhmucs;
getDanhMuc() async {
  danhmucs = (await RemoteServiceDanhMuc().getDanhMuc())!.cast<DanhMuc>();
}