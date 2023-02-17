// To parse this JSON data, do
//
//     final tieuChi = tieuChiFromJson(jsonString);

import 'dart:convert';

import 'package:atvs/remote_service.dart';

import 'chi_tiet_tieu_chi.dart';

List<TieuChi> tieuChiFromJson(String str) => List<TieuChi>.from(json.decode(str).map((x) => TieuChi.fromJson(x)));

String tieuChiToJson(List<TieuChi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TieuChi {
    TieuChi({
        required this.id,
        required this.tenDm,
        required this.sothutu,
    });

    int id;
    String tenDm;
    String sothutu;

    factory TieuChi.fromJson(Map<String, dynamic> json) => TieuChi(
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
List<TieuChi>? tieuchis;
getTieuChi() async {
    tieuchis = (await RemoteServiceTieuChi().getTieuChi());
}