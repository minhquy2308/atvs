import 'dart:convert';

import 'package:atvs/remote_service.dart';

List<NoiDung?>? noiDungFromJson(String str) => json.decode(str) == null ? [] : List<NoiDung?>.from(json.decode(str)!.map((x) => NoiDung.fromJson(x)));

String noiDungToJson(List<NoiDung?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class NoiDung {
  NoiDung({
    required this.id,
    required this.noidung,
    required this.idDanhmuc,
    required this.idChitiettieuchi,
  });

  int? id;
  String? noidung;
  String? idDanhmuc;
  String? idChitiettieuchi;
  dynamic createdAt;
  dynamic updatedAt;

  factory NoiDung.fromJson(Map<String, dynamic> json) => NoiDung(
    id: json["id"],
    noidung: json["noidung"],
    idDanhmuc: json["id_danhmuc"],
    idChitiettieuchi: json["id_chitiettieuchi"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "noidung": noidung,
    "id_danhmuc": idDanhmuc,
    "id_chitiettieuchi": idChitiettieuchi,
  };
}
List<NoiDung>? noidungs;
getNoiDung() async {
  noidungs = (await RemoteServiceNoiDung().getNoiDung())!.cast<NoiDung>();
}