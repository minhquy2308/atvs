import 'dart:convert';

import 'package:atvs/remote_service.dart';

List<Donvi> donviFromJson(String str) =>
    List<Donvi>.from(json.decode(str).map((x) => Donvi.fromJson(x)));

String donviToJson(List<Donvi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donvi {
  Donvi({
    required this.id,
    required this.tenDv,
  });

  int id;
  String tenDv;

  factory Donvi.fromJson(Map<String, dynamic> json) => Donvi(
        id: json["id"],
        tenDv: json["ten_dv"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ten_dv": tenDv,
      };
}

List<Donvi>? donvis, donvicon = [];

getDonVi() async {
  donvis = (await RemoteServiceDonVi().getDonVi());
}

getDonViCon() async {
  if (donvicon!.isEmpty) {
    for (int i = 0; i < donvis!.length; i++) {
      if (donvis![i].id == 8 || donvis![i].id == 9 || donvis![i].id == 110) {

      }
      else{
        donvicon!.add(donvis![i]);
      }
    }
  }
}
