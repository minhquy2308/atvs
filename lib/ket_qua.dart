import 'dart:convert';

Ketqua ketquaFromJson(String str) => Ketqua.fromJson(json.decode(str));

String ketquaToJson(Ketqua data) => json.encode(data.toJson());

class Ketqua {
  Ketqua({
    required this.noidung,
    required this.donviId,
    required this.userId,
    required this.kyId,
  });

  List<Noidung> noidung;
  String donviId;
  String userId;
  String kyId;

  factory Ketqua.fromJson(Map<String, dynamic> json) => Ketqua(
        noidung:
            List<Noidung>.from(json["noidung"].map((x) => Noidung.fromJson(x))),
        donviId: json["donvi_id"],
        userId: json["user_id"],
        kyId: json["ky_id"],
      );

  Map<String, dynamic> toJson() => {
        "noidung": List<dynamic>.from(noidung.map((x) => x.toJson())),
        "donvi_id": donviId,
        "user_id": userId,
        "ky_id": kyId,
      };
}

class Noidung {
  Noidung({
    required this.noidungId,
    required this.soDiem,
    required this.danhmucId,
    required this.chitietId,
  });

  int noidungId;
  String soDiem;
  String danhmucId;
  int chitietId;

  factory Noidung.fromJson(Map<String, dynamic> json) => Noidung(
        noidungId: json["noidung_id"],
        soDiem: json["so_diem"],
        danhmucId: json["danhmuc_id"],
        chitietId: json["chitiet_id"],
      );

  Map<String, dynamic> toJson() => {
        "noidung_id": noidungId,
        "so_diem": soDiem,
        "danhmuc_id": danhmucId,
        "chitiet_id": chitietId,
      };
}

List<Noidung> cacnoidung = [];

createNoidung(List<String> diem) {
  cacnoidung = [
    Noidung(noidungId: 1, soDiem: diem[0], danhmucId: "1", chitietId: 1),
    Noidung(noidungId: 2, soDiem: diem[1], danhmucId: "1", chitietId: 2),
    Noidung(noidungId: 3, soDiem: diem[2], danhmucId: "1", chitietId: 3),
    Noidung(noidungId: 4, soDiem: diem[3], danhmucId: "1", chitietId: 4),
    Noidung(noidungId: 5, soDiem: diem[4], danhmucId: "1", chitietId: 5),
    Noidung(noidungId: 6, soDiem: diem[5], danhmucId: "1", chitietId: 6),
    Noidung(noidungId: 7, soDiem: diem[6], danhmucId: "1", chitietId: 7),
    Noidung(noidungId: 8, soDiem: diem[7], danhmucId: "1", chitietId: 8),
    Noidung(noidungId: 9, soDiem: diem[8], danhmucId: "1", chitietId: 9),
    Noidung(noidungId: 10, soDiem: diem[9], danhmucId: "1", chitietId: 9),
    Noidung(noidungId: 11, soDiem: diem[10], danhmucId: "2", chitietId: 10),
    Noidung(noidungId: 12, soDiem: diem[11], danhmucId: "2", chitietId: 10),
    Noidung(noidungId: 13, soDiem: diem[12], danhmucId: "2", chitietId: 10),
    Noidung(noidungId: 14, soDiem: diem[13], danhmucId: "2", chitietId: 10),
    Noidung(noidungId: 15, soDiem: diem[14], danhmucId: "2", chitietId: 10),
    Noidung(noidungId: 16, soDiem: diem[15], danhmucId: "2", chitietId: 10),
    Noidung(noidungId: 17, soDiem: diem[16], danhmucId: "2", chitietId: 11),
    Noidung(noidungId: 18, soDiem: diem[17], danhmucId: "2", chitietId: 11),
    Noidung(noidungId: 19, soDiem: diem[18], danhmucId: "2", chitietId: 11),
    Noidung(noidungId: 20, soDiem: diem[19], danhmucId: "2", chitietId: 11),
    Noidung(noidungId: 21, soDiem: diem[20], danhmucId: "3", chitietId: 12),
    Noidung(noidungId: 22, soDiem: diem[21], danhmucId: "3", chitietId: 12),
    Noidung(noidungId: 23, soDiem: diem[22], danhmucId: "3", chitietId: 13),
    Noidung(noidungId: 24, soDiem: diem[23], danhmucId: "3", chitietId: 13),
    Noidung(noidungId: 25, soDiem: diem[24], danhmucId: "3", chitietId: 13),
    Noidung(noidungId: 26, soDiem: diem[25], danhmucId: "3", chitietId: 13),
    Noidung(noidungId: 27, soDiem: diem[26], danhmucId: "3", chitietId: 13),
    Noidung(noidungId: 28, soDiem: diem[27], danhmucId: "3", chitietId: 14),
    Noidung(noidungId: 29, soDiem: diem[28], danhmucId: "3", chitietId: 15),
    Noidung(noidungId: 30, soDiem: diem[29], danhmucId: "3", chitietId: 15),
    Noidung(noidungId: 31, soDiem: diem[30], danhmucId: "4", chitietId: 15),
    Noidung(noidungId: 32, soDiem: diem[31], danhmucId: "4", chitietId: 16),
    Noidung(noidungId: 33, soDiem: diem[32], danhmucId: "4", chitietId: 16),
    Noidung(noidungId: 34, soDiem: diem[33], danhmucId: "4", chitietId: 17),
    Noidung(noidungId: 35, soDiem: diem[34], danhmucId: "4", chitietId: 17),
    Noidung(noidungId: 36, soDiem: diem[35], danhmucId: "4", chitietId: 17),
    Noidung(noidungId: 37, soDiem: diem[36], danhmucId: "4", chitietId: 17),
    Noidung(noidungId: 38, soDiem: diem[37], danhmucId: "4", chitietId: 17),
    Noidung(noidungId: 39, soDiem: diem[38], danhmucId: "4", chitietId: 18),
    Noidung(noidungId: 40, soDiem: diem[39], danhmucId: "4", chitietId: 19),
    Noidung(noidungId: 41, soDiem: diem[40], danhmucId: "5", chitietId: 20),
    Noidung(noidungId: 42, soDiem: diem[41], danhmucId: "5", chitietId: 20),
    Noidung(noidungId: 43, soDiem: diem[42], danhmucId: "5", chitietId: 20),
    Noidung(noidungId: 44, soDiem: diem[43], danhmucId: "5", chitietId: 20),
    Noidung(noidungId: 45, soDiem: diem[44], danhmucId: "5", chitietId: 20),
    Noidung(noidungId: 46, soDiem: diem[45], danhmucId: "5", chitietId: 20),
    Noidung(noidungId: 47, soDiem: diem[46], danhmucId: "5", chitietId: 21),
    Noidung(noidungId: 48, soDiem: diem[47], danhmucId: "5", chitietId: 21),
    Noidung(noidungId: 49, soDiem: diem[48], danhmucId: "5", chitietId: 21),
    Noidung(noidungId: 50, soDiem: diem[49], danhmucId: "5", chitietId: 21),
  ];
}
