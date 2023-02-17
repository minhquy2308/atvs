import 'dart:convert';

import 'package:atvs/remote_service.dart';

List<ChiTietTieuChi?>? chiTietTieuChiFromJson(String str) => json.decode(str) == null ? [] : List<ChiTietTieuChi?>.from(json.decode(str)!.map((x) => ChiTietTieuChi.fromJson(x)));

String chiTietTieuChiToJson(List<ChiTietTieuChi?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class ChiTietTieuChi {
  ChiTietTieuChi({
    required this.id,
    required this.name,
    required this.idDanhmuc,
  });

  int? id;
  String? name;
  String? idDanhmuc;


  factory ChiTietTieuChi.fromJson(Map<String, dynamic> json) => ChiTietTieuChi(
    id: json["id"],
    name: json["name"],
    idDanhmuc: json["id_danhmuc"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "id_danhmuc": idDanhmuc,
  };
}
List<ChiTietTieuChi>? chitiettieuchis;
getChiTietTieuChi() async {
  chitiettieuchis = (await RemoteServiceChiTietTieuChi().getChiTietTieuChi())!.cast<ChiTietTieuChi>();
}