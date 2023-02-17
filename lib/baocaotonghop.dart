// To parse this JSON data, do
//
//     final hoTro = hoTroFromJson(jsonString);
import 'dart:convert';

import 'baocao.dart';
import 'remote_service.dart';

// List<BaoCao> baoCaoFromJson(String str) =>
//     List<BaoCao>.from(json.decode(str).map((x) => BaoCao.fromJson(x)));

// List<Data> dataFromJson(String str) =>
    // List<Data>.from(json.decode(str).map((x) => BaoCao.fromJson(x)));
List<Thang>? baocaos;
List<Data>? datas;

class BaoCao {
  BaoCao({
    required this.month,
    required this.data,
  });

  int month;
  List<dynamic> data;

  factory BaoCao.fromJson(Map<String, dynamic> json) => BaoCao(
        month: json["month"],
        data: json["data"],
      );
}

getBaocao() async {
  baocaos = await RemoteServiceBaoCao().getBaoCao();
}
// getData(){
//   for (var baocaos in baocaos!) {datas!.add(datas);
//   }
// }