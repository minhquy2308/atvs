import 'dart:convert';

import 'ket_qua.dart';

ThamDinh thamDinhFromJson(String str) => ThamDinh.fromJson(json.decode(str));

String thamDinhToJson(ThamDinh data) => json.encode(data.toJson());

class ThamDinh {
  ThamDinh({
    required this.noidung,
    required this.userId,
  });

  List<Noidung> noidung;
  String userId;

  factory ThamDinh.fromJson(Map<String, dynamic> json) => ThamDinh(
    noidung: List<Noidung>.from(json["noidung"].map((x) => Noidung.fromJson(x))),
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "noidung": List<dynamic>.from(noidung.map((x) => x.toJson())),
    "user_id": userId,
  };
}


