import 'dart:convert';
import 'package:atvs/remote_service.dart';

import 'donvi.dart';

List<PhieuDaTao> phieuDaTaoFromJson(String str) =>
    List<PhieuDaTao>.from(json.decode(str).map((x) => PhieuDaTao.fromJson(x)));

String phieuDaTaoToJson(List<PhieuDaTao> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
String idphieu="";
class PhieuDaTao {
  PhieuDaTao({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.khoitao,
    required this.donvi,
    required this.user,
  });

  int id;
  String title;
  DateTime createdAt;
  DateTime updatedAt;
  String khoitao;
  Donvi donvi;
  User user;

  factory PhieuDaTao.fromJson(Map<String, dynamic> json) => PhieuDaTao(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        khoitao: json["khoitao"],
        donvi: Donvi.fromJson(json["donvi"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "khoitao": khoitao,
        "donvi": donvi.toJson(),
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.donviId,
    required this.roleId,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String donviId;
  String roleId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        donviId: json["donvi_id"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "donvi_id": donviId,
        "role_id": roleId,
      };
}

List<PhieuDaTao>? phieus = [];

getPhieuDaTao() async {
  phieus = (await RemoteServicePhieu().getPhieu());
}
