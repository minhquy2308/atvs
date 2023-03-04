import 'dart:convert';

Phieu phieuFromJson(String str) => Phieu.fromJson(json.decode(str));

String phieuToJson(Phieu data) => json.encode(data.toJson());

class Phieu {
  Phieu({
    required this.title,
    required this.donviId,
    required this.noidung,
    required this.userId,
  });

  String title;
  String donviId;
  List<Noidung> noidung;
  String userId;

  factory Phieu.fromJson(Map<String, dynamic> json) => Phieu(
    title: json["title"],
    donviId: json["donvi_id"],
    noidung: List<Noidung>.from(json["noidung"].map((x) => Noidung.fromJson(x))),
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "donvi_id": donviId,
    "noidung": List<dynamic>.from(noidung.map((x) => x.toJson())),
    "user_id": userId,
  };
}

class Noidung {
  Noidung({
    required this.noidungId,
    required this.soDiem,
  });

  int noidungId;
  String soDiem;

  factory Noidung.fromJson(Map<String, dynamic> json) => Noidung(
    noidungId: json["noidung_id"],
    soDiem: json["so_diem"],
  );

  Map<String, dynamic> toJson() => {
    "noidung_id": noidungId,
    "so_diem": soDiem,
  };
}
List<Noidung> cacnoidungphieu = [];
createNoidungPhieu(List<String> diem) {
  cacnoidungphieu = [
    Noidung(noidungId: 1, soDiem: diem[0]),
    Noidung(noidungId: 2, soDiem: diem[1]),
    Noidung(noidungId: 3, soDiem: diem[2]),
    Noidung(noidungId: 4, soDiem: diem[3]),
    Noidung(noidungId: 5, soDiem: diem[4]),
    Noidung(noidungId: 6, soDiem: diem[5]),
    Noidung(noidungId: 7, soDiem: diem[6]),
    Noidung(noidungId: 8, soDiem: diem[7]),
    Noidung(noidungId: 9, soDiem: diem[8]),
    Noidung(noidungId: 10, soDiem: diem[9]),
    Noidung(noidungId: 11, soDiem: diem[10]),
    Noidung(noidungId: 12, soDiem: diem[11]),
    Noidung(noidungId: 13, soDiem: diem[12]),
    Noidung(noidungId: 14, soDiem: diem[13]),
    Noidung(noidungId: 15, soDiem: diem[14]),
    Noidung(noidungId: 16, soDiem: diem[15]),
    Noidung(noidungId: 17, soDiem: diem[16]),
    Noidung(noidungId: 18, soDiem: diem[17]),
    Noidung(noidungId: 19, soDiem: diem[18]),
    Noidung(noidungId: 20, soDiem: diem[19]),
    Noidung(noidungId: 21, soDiem: diem[20]),
    Noidung(noidungId: 22, soDiem: diem[21]),
    Noidung(noidungId: 23, soDiem: diem[22]),
    Noidung(noidungId: 24, soDiem: diem[23]),
    Noidung(noidungId: 25, soDiem: diem[24]),
    Noidung(noidungId: 26, soDiem: diem[25]),
    Noidung(noidungId: 27, soDiem: diem[26]),
    Noidung(noidungId: 28, soDiem: diem[27]),
    Noidung(noidungId: 29, soDiem: diem[28]),
    Noidung(noidungId: 30, soDiem: diem[29]),
    Noidung(noidungId: 31, soDiem: diem[30]),
    Noidung(noidungId: 32, soDiem: diem[31]),
    Noidung(noidungId: 33, soDiem: diem[32]),
    Noidung(noidungId: 34, soDiem: diem[33]),
    Noidung(noidungId: 35, soDiem: diem[34]),
    Noidung(noidungId: 36, soDiem: diem[35]),
    Noidung(noidungId: 37, soDiem: diem[36]),
    Noidung(noidungId: 38, soDiem: diem[37]),
    Noidung(noidungId: 39, soDiem: diem[38]),
    Noidung(noidungId: 40, soDiem: diem[39]),
    Noidung(noidungId: 41, soDiem: diem[40]),
    Noidung(noidungId: 42, soDiem: diem[41]),
    Noidung(noidungId: 43, soDiem: diem[42]),
    Noidung(noidungId: 44, soDiem: diem[43]),
    Noidung(noidungId: 45, soDiem: diem[44]),
    Noidung(noidungId: 46, soDiem: diem[45]),
    Noidung(noidungId: 47, soDiem: diem[46]),
    Noidung(noidungId: 48, soDiem: diem[47]),
    Noidung(noidungId: 49, soDiem: diem[48]),
    Noidung(noidungId: 50, soDiem: diem[49]),
  ];
}

