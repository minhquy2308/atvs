
import 'dart:convert';

import 'baocao.dart';
import 'remote_service.dart';
List<Thang>? baocaos=[];
List<Data>? datas=[];

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