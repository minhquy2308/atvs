// To parse this JSON data, do
//
//     final hoTro = hoTroFromJson(jsonString);
import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:atvs/section.dart';
import 'remote_service.dart';
import 'package:intl/intl.dart';

List<HoTro> hoTroFromJson(String str) =>
    List<HoTro>.from(json.decode(str).map((x) => HoTro.fromJson(x)));
List<HoTro>? hotros;

String hoTroToJson(List<HoTro> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HoTro {
  HoTro(
      {required this.id,
      required this.tenKhachhang,
      required this.khachhangid,
      required this.noidungid,
        required this.dichvuid,
      required this.tenCoquan,
      required this.sodienthoai,
      required this.tenDichvu,
      required this.name,
      required this.trangthai,
      required this.createdAt,
      required this.dagoikiem});

  String id;
  String tenKhachhang;
  String khachhangid;
  String noidungid;
  String dichvuid;
  String tenCoquan;
  String sodienthoai;
  String tenDichvu;
  String name;
  String trangthai;
  DateTime createdAt;
  String dagoikiem;

  factory HoTro.fromJson(Map<String, dynamic> json) => HoTro(
      id: json["id"],
      tenKhachhang: json["ten_khachhang"],
      khachhangid: json["khachhang_id"],
      noidungid: json["noidung_id"],
      dichvuid: json["dichvu_id"],
      tenCoquan: json["ten_coquan"],
      sodienthoai: json["sodienthoai"],
      tenDichvu: json["ten_dichvu"],
      name: json["name"],
      trangthai: json["trangthai"],
      createdAt: DateTime.parse(json["created_at"]),
      dagoikiem: json["dagoikiem"]);

  Map<String, dynamic> toJson() => {
        "ten_khachhang": tenKhachhang,
        "ten_coquan": tenCoquan,
        "sodienthoai": sodienthoai,
        "ten_dichvu": tenDichvu,
        "name": name,
        "trangthai": trangthai,
        "created_at": createdAt.toIso8601String(),
      };
}

getHotros() async {
  hotros = await RemoteServiceHoTro().getHoTro();
}

class DanhSachCuocGoi extends StatefulWidget {
  const DanhSachCuocGoi({super.key});

  @override
  State<DanhSachCuocGoi> createState() => _DanhSachCuocGoiState();
}

class _DanhSachCuocGoiState extends State<DanhSachCuocGoi> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
          columnSpacing: 6,
          horizontalMargin: 6,
          // minWidth: 600,
          columns: const [
            DataColumn2(label: Text('STT'), fixedWidth: 30),
            DataColumn2(
              label: Text('Họ tên'),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text('Cơ quan'),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text('SĐT'),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text('DV'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Người hỗ trợ'),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text('Khởi tạo'),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text('Trạng\nthái'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Gọi kiểm'),
              size: ColumnSize.M,
            ),
          ],
          rows: List<DataRow>.generate(
              hotros!.length,
              (index) => DataRow(cells: [
                    DataCell(Text((index + 1).toString())),
                    DataCell(Text(hotros![index].tenKhachhang)),
                    DataCell(Text(hotros![index].tenCoquan)),
                    DataCell(Text(hotros![index].sodienthoai)),
                    DataCell(Text(hotros![index].tenDichvu)),
                    DataCell(Text(hotros![index].name)),
                    DataCell(Text(DateFormat('dd/MM/yyyy')
                        .format(hotros![index].createdAt))),
                    hotros![index].trangthai.toString() == '1'
                        ? const DataCell(Icon(Icons.done, color: Colors.green))
                        : const DataCell(
                            Icon(Icons.stop_circle, color: Colors.green)),
                    hotros![index].dagoikiem.toString() == '0'
                        ? DataCell(ElevatedButton(
                            onPressed: () {
                              idhotro = hotros![index].id;
                              khachhangid = hotros![index].khachhangid;
                              noidungid = hotros![index].noidungid;
                              iddichvu = hotros![index].dichvuid;
                              Navigator.pushNamed(context, '/GoiKiem');
                            },
                            child: const Text("Gọi kiểm",style: TextStyle(fontSize: 12),),
                          ))
                        : const DataCell(Icon(Icons.done, color: Colors.green))
                  ]))),
    ));
  }
}
