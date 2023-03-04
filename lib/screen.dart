import 'package:atvs/ket_qua.dart';
import 'package:atvs/login.dart';
import 'package:atvs/phieu.dart';
import 'package:atvs/phieu_da_tao.dart';
import 'package:atvs/remote_service.dart';
import 'package:atvs/tham_dinh.dart';
import 'package:atvs/tieu_chi.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'baocaotonghop.dart';
import 'chi_tiet_phieu.dart';
import 'diem_chi_tiet.dart';
import 'donvi.dart';
import 'noi_dung.dart';
import 'section.dart';
import 'navigation_drawer.dart';
String send = "";
var stt = 0, iddonvi = 0, tendv = "";
List<String> diem = [];
List<int> soTrang = [0,1,2,3,4];
List<TextEditingController> _controller = [
  for (int i = 0; i < 51; i++) TextEditingController()
];

clearDiem() {
  for (int i = 0; i < _controller.length; i++) {
    _controller[i].clear();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  baoCao(int thang) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
          columnSpacing: 1,
          horizontalMargin: 1,
          minWidth: 50,
          columns: const [
            DataColumn2(
              label: Text('TT'),
              fixedWidth: 25,
            ),
            DataColumn2(
              label: Text(
                'Đơn vị',
                textAlign: TextAlign.center,
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                'Tự\nđánh\ngiá',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              fixedWidth: 35,
            ),
            DataColumn2(
              label: Text(
                'Thẩm\nđịnh',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              fixedWidth: 40,
            ),
            DataColumn2(
              label: Text(
                'Chi tiết',
                style: TextStyle(fontSize: 12),
              ),
              fixedWidth: 45,
            ),
          ],
          rows: List<DataRow>.generate(
              baocaos![thang].data.length,
              (index) => DataRow(cells: [
                    DataCell(Text((index + 1).toString())),
                    DataCell(Text(
                        (baocaos![thang].data[index].tenDonvi.toString()))),
                    DataCell(Text(
                        (baocaos![thang].data[index].sumDiemdonvi.toString()))),
                    DataCell((baocaos![thang]
                                .data[index]
                                .sumDiemtothamdinh
                                .toString() ==
                            'null'
                        ? const Icon(Icons.not_interested)
                        : Text((baocaos![thang]
                            .data[index]
                            .sumDiemtothamdinh
                            .toString())))),
                    DataCell(TextButton(
                      onPressed: () {
                        getDiemChiTiet(
                            baocaos![thang].data[index].donviId.toString(),
                            baocaos![thang].data[index].idKy.toString());
                        stt = 0;
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.pushNamed(context, '/ChiTiet');
                        });
                      },
                      child: const Text(
                        "Xem",
                        style: TextStyle(fontSize: 12),
                      ),
                    ))
                  ]))),
    ));
  }

  chuaThucHien(int thang) {
    return baocaos![thang].chuaDanhgia.toString() == 'null'
        ? const Text('')
        : Column(
            children: <Widget>[
              const SizedBox(width: 30),
              const Text('Đơn vị chưa thực hiện:'),
              const SizedBox(width: 20),
              Text(baocaos![thang].chuaDanhgia.toString().replaceAll(',', '\n'))
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá an toàn vệ sinh lao động'),
      ),
      drawer: const NavigationDrawer1(),
      body: Column(children: [
        const ThangNam(),
        baocaos!.isEmpty
            ? const Text("Có lỗi xảy ra khi kết nối tới máy chủ")
            : baoCao(chonThang),
        baocaos!.isEmpty
            ? const Text("Có lỗi xảy ra khi kết nối tới máy chủ")
            : chuaThucHien(chonThang),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Dấu'),
            Icon(Icons.not_interested),
            Text(': chưa thẩm định'),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ]),
    );
  }
}

class ChiTiet extends StatefulWidget {
  const ChiTiet({super.key});

  @override
  State<ChiTiet> createState() => _ChiTietState();
}

class _ChiTietState extends State<ChiTiet> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  diemChiTiet(int stt) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 10, // Some height
          ),
          Text(
              '${tieuchis![stt].sothutu.toString()}. ${tieuchis![stt].tenDm.toString()} ',
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
                columnSpacing: 10,
                horizontalMargin: 0.3,
                minWidth: 5,
                dataRowHeight: 220,
                border: TableBorder.all(),
                columns: const [
                  DataColumn2(
                    label: Text('#'),
                    fixedWidth: 30,
                  ),
                  DataColumn2(
                    label: Text(
                      'Đối tượng\nđánh giá',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                    fixedWidth: 65,
                  ),
                  DataColumn2(
                    label: Text(
                      'Nội dung tiêu chí',
                      textAlign: TextAlign.center,
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text(
                      'Điểm\nchỉ\ntiêu',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    fixedWidth: 40,
                  ),
                  DataColumn2(
                    label: Text('Điểm\nđơn vị\nchấm',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center),
                    fixedWidth: 40,
                  ),
                  DataColumn2(
                    label: Text('Điểm\nthẩm\nđịnh',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center),
                    fixedWidth: 40,
                  ),
                ],
                rows: List<DataRow>.generate(
                    10,
                    (index) => DataRow(cells: [
                          DataCell(Text((index + 1 + stt * 10).toString())),
                          DataCell(doiTuongDanhGia(index + stt * 10)),
                          DataCell(Text(
                              (noidungs![index + stt * 10].noidung.toString()),
                              textAlign: TextAlign.justify)),
                          const DataCell(Text('2')),
                          DataCell(Text(
                              (diemchitiets![index + stt * 10]
                                  .diemdonvi
                                  .toString()),
                              textAlign: TextAlign.center)),
                          DataCell(diemchitiets![index + stt * 10]
                                      .diemtothamdinh
                                      .toString() ==
                                  "null"
                              ? const Icon(Icons.not_interested)
                              : Text(
                                  diemchitiets![index + stt * 10]
                                      .diemtothamdinh
                                      .toString(),
                                  textAlign: TextAlign.center))
                        ]))),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điểm chi tiết đơn vị'),
      ),
      drawer: const NavigationDrawer1(),
      body: Column(children: [
        diemChiTiet(stt),
        const SizedBox(height: 20),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              const Text('Trang:'),
              for ( var i in soTrang ) trang(i, 'ChiTiet', context),
            ],
          ),
        )
      ]),
    );
  }
}

class XemPhieu extends StatefulWidget {
  const XemPhieu({super.key});

  @override
  State<XemPhieu> createState() => _XemPhieuState();
}

class _XemPhieuState extends State<XemPhieu> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  diemChiTiet(int stt) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 10, // Some height
          ),
          Text(
              '${tieuchis![stt].sothutu.toString()}. ${tieuchis![stt].tenDm.toString()} ',
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
                columnSpacing: 10,
                horizontalMargin: 0.3,
                minWidth: 5,
                dataRowHeight: 220,
                border: TableBorder.all(),
                columns: const [
                  DataColumn2(
                    label: Text('#'),
                    fixedWidth: 30,
                  ),
                  DataColumn2(
                    label: Text(
                      'Đối tượng\nđánh giá',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                    fixedWidth: 65,
                  ),
                  DataColumn2(
                    label: Text(
                      'Nội dung tiêu chí',
                      textAlign: TextAlign.center,
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text(
                      'Điểm\nchỉ\ntiêu',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    fixedWidth: 40,
                  ),
                  DataColumn2(
                    label: Text('Đánh\ngiá',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center),
                    fixedWidth: 40,
                  ),
                ],
                rows: List<DataRow>.generate(
                    10,
                    (index) => DataRow(cells: [
                          DataCell(Text((index + 1 + stt * 10).toString())),
                          DataCell(doiTuongDanhGia(index + stt * 10)),
                          DataCell(Text(
                              (noidungs![index + stt * 10].noidung.toString()),
                              textAlign: TextAlign.justify)),
                          const DataCell(Text('2')),
                          DataCell(Text(
                              (phieu!.kiemtra[index + stt * 10].diemDanhgia
                                  .toString()),
                              textAlign: TextAlign.center)),
                        ]))),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(phieu!.title, style: const TextStyle(fontSize: 13),),
      ),
      drawer: const NavigationDrawer1(),
      body: Column(children: [
        diemChiTiet(stt),
        const SizedBox(height: 20),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              const Text('Trang:'),
              for ( var i in soTrang ) trang(i, 'XemPhieu', context),
            ],
          ),
        )
      ]),
    );
  }
}

guiDiem() {
  diem = [];
  for (int i = 0; i < 50; i++) {
    diem.add(_controller[i].text);
  }
}

bool err = false, empty = false;
int loi = 0;

checkEmpty() {
  for (int i = 0; i < 50; i++) {
    if (_controller[i].text.isEmpty) {
      empty = true;
      loi = i;
      break;
    }
  }
}

validate() {
  for (int i = 0; i < 50; i++) {
    if (_controller[i].text == "1" || _controller[i].text == "2") {
      err = false;
    } else {
      err = true;
      loi = i;
      break;
    }
  }
}

class ReviewKy extends StatefulWidget {
  const ReviewKy({super.key});

  @override
  State<ReviewKy> createState() => _ReviewKyState();
}

class _ReviewKyState extends State<ReviewKy> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  diemChiTiet(int stt) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 10, // Some height
          ),
          Text(
              '${tieuchis![stt].sothutu.toString()}. ${tieuchis![stt].tenDm.toString()} ',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
                columnSpacing: 10,
                horizontalMargin: 0.3,
                minWidth: 5,
                dataRowHeight: 200,
                border: TableBorder.all(),
                columns: const [
                  DataColumn2(
                    label: Text('#'),
                    fixedWidth: 30,
                  ),
                  DataColumn2(
                    label: Text(
                      'Đối tượng\nđánh giá',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                    fixedWidth: 65,
                  ),
                  DataColumn2(
                    label: Text(
                      'Nội dung tiêu chí',
                      textAlign: TextAlign.center,
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text(
                      'Điểm\nchỉ\ntiêu',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    fixedWidth: 40,
                  ),
                  DataColumn2(
                    label: Text('Điểm\nđơn vị\nchấm',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center),
                    fixedWidth: 40,
                  ),
                ],
                rows: List<DataRow>.generate(
                    10,
                    (index) => DataRow(cells: [
                          DataCell(Text((index + 1 + stt * 10).toString())),
                          DataCell(doiTuongDanhGia(index + stt * 10)),
                          DataCell(Text(
                              (noidungs![index + stt * 10].noidung.toString()),
                              textAlign: TextAlign.justify)),
                          const DataCell(Text('2')),
                          DataCell(TextField(
                            controller: _controller[index + stt * 10],
                          )),
                        ]))),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá an toàn vệ sinh lao động'),
      ),
      drawer: const NavigationDrawer1(),
      body: Column(children: [
        diemChiTiet(stt),
        const SizedBox(height: 20),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Row(
            children: [
              const Text('Trang:'),
              for ( var i in soTrang ) trang(i, 'reviewky', context),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              err = false;
              empty = false;
              checkEmpty();
              validate();
              if (empty == true) {
                showNoti(context,
                    "Chưa điền đù điểm,\nvui lòng kiểm tra lại!\n Lỗi ở ô $loi");
              } else if (err == true) {
                showNoti(context,
                    "Điểm chỉ được nhập giá trị 1 hoặc 2,\nvui lòng kiểm tra lại!\n Lỗi ở ô $loi");
              } else {
                guiDiem();
                createNoidung(diem);
                send = ketquaToJson(Ketqua(
                    noidung: cacnoidung,
                    donviId: donviiduser,
                    userId: uid,
                    kyId: kyid.toString()));
                RemoteServiceKetQua().guiKetQua();
                if (errorPost) {
                  errmsg(context, "Có lỗi xảy ra, vui lòng thử lại sau");
                } else {
                  showNoti(context, "Thành công");
                }
              }
            },
            child: const Text("Gửi"))
      ]),
    );
  }
}

class RateKy extends StatefulWidget {
  const RateKy({super.key});

  @override
  State<RateKy> createState() => _RateKyState();
}

class _RateKyState extends State<RateKy> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  diemChiTiet(int stt) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 10, // Some height
          ),
          Text(
              '${tieuchis![stt].sothutu.toString()}. ${tieuchis![stt].tenDm.toString()} ',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
                columnSpacing: 10,
                horizontalMargin: 0.3,
                minWidth: 5,
                dataRowHeight: 270,
                border: TableBorder.all(),
                columns: const [
                  DataColumn2(
                    label: Text('#'),
                    fixedWidth: 30,
                  ),
                  DataColumn2(
                    label: Text(
                      'Đối tượng\nđánh giá',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                    fixedWidth: 85,
                  ),
                  DataColumn2(
                    label: Text(
                      'Nội dung tiêu chí',
                      textAlign: TextAlign.center,
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text(
                      'Điểm\nchỉ\ntiêu',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    fixedWidth: 40,
                  ),
                  DataColumn2(
                    label: Text('Điểm\nđơn vị\nchấm',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center),
                    fixedWidth: 40,
                  ),
                  DataColumn2(
                    label: Text('Điểm\nthẩm\nđịnh',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center),
                    fixedWidth: 40,
                  ),
                ],
                rows: List<DataRow>.generate(
                    10,
                    (index) => DataRow(cells: [
                          DataCell(Text((index + 1 + stt * 10).toString())),
                          DataCell(doiTuongDanhGia(index + stt * 10)),
                          DataCell(Text(
                              (noidungs![index + stt * 10].noidung.toString()),
                              textAlign: TextAlign.justify)),
                          const DataCell(Text('2')),
                          DataCell(Text(
                              (diemchitiets![index + stt * 10]
                                  .diemdonvi
                                  .toString()),
                              textAlign: TextAlign.center)),
                          DataCell(TextField(
                            textInputAction: TextInputAction.next,
                            controller: _controller[index + stt * 10],
                          )),
                        ]))),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá an toàn vệ sinh lao động'),
      ),
      drawer: const NavigationDrawer1(),
      body: Column(children: [
        diemChiTiet(stt),
        const SizedBox(height: 20),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Row(
            children: [
              const Text('Trang:'),
              for ( var i in soTrang ) trang(i, 'ThamDinhKy', context),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              err = false;
              empty = false;
              checkEmpty();
              validate();
              if (empty == true) {
                showNoti(context,
                    "Chưa điền đù điểm,\nvui lòng kiểm tra lại!\n Lỗi ở ô $loi");
              } else if (err == true) {
                showNoti(context,
                    "Điểm chỉ được nhập giá trị 1 hoặc 2,\nvui lòng kiểm tra lại!\n Lỗi ở ô $loi");
              } else {
                guiDiem();
                createNoidung(diem);
                send = thamDinhToJson(ThamDinh(noidung: cacnoidung, userId: uid));
                RemoteServiceThamDinh().taoPhieu(send);
                if (errorPost) {
                  errmsg(context, "Có lỗi xảy ra, vui lòng thử lại sau");
                } else {
                  showResult(context, "ThamDinh");
                }
              }
            },
            child: const Text("Gửi"))
      ]),
    );
  }
}
List<TextButton> cactrang = [];
trang(int index, String route, BuildContext context){
    return TextButton(
        onPressed: () {
          stt = index;
          Navigator.pushNamed(context, '/$route');
        },
        child: stt == index
            ? Text((index+1).toString(),
            style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.red))
            : Text((index+1).toString()));
}

class KiemTraKy extends StatefulWidget {
  const KiemTraKy({super.key});

  @override
  State<KiemTraKy> createState() => _KiemTraKyState();
}

class _KiemTraKyState extends State<KiemTraKy> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  diemChiTiet(int stt) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 10, // Some height
          ),
          Text(
              '${tieuchis![stt].sothutu.toString()}. ${tieuchis![stt].tenDm.toString()} ',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
                columnSpacing: 10,
                horizontalMargin: 0.3,
                minWidth: 5,
                dataRowHeight: 200,
                border: TableBorder.all(),
                columns: const [
                  DataColumn2(
                    label: Text('#'),
                    fixedWidth: 30,
                  ),
                  DataColumn2(
                    label: Text(
                      'Đối tượng\nđánh giá',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                    fixedWidth: 65,
                  ),
                  DataColumn2(
                    label: Text(
                      'Nội dung tiêu chí',
                      textAlign: TextAlign.center,
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text(
                      'Điểm\nchỉ\ntiêu',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    fixedWidth: 40,
                  ),
                  DataColumn2(
                    label: Text('Đánh\ngiá',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center),
                    fixedWidth: 40,
                  ),
                ],
                rows: List<DataRow>.generate(
                    10,
                    (index) => DataRow(cells: [
                          DataCell(Text((index + 1 + stt * 10).toString())),
                          DataCell(doiTuongDanhGia(index + stt * 10)),
                          DataCell(Text(
                              (noidungs![index + stt * 10].noidung.toString()),
                              textAlign: TextAlign.justify)),
                          const DataCell(Text('2')),
                          DataCell(TextField(
                            controller: _controller[index + stt * 10],
                          )),
                        ]))),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá an toàn vệ sinh lao động'),
      ),
      drawer: const NavigationDrawer1(),
      body: Column(children: [
        diemChiTiet(stt),
        const SizedBox(height: 20),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Row(
            children: [
              const Text('Trang:'),
              for ( var i in soTrang ) trang(i, 'KiemTraKy', context),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              err = false;
              empty = false;
              checkEmpty();
              validate();
              if (empty == true) {
                showNoti(context,
                    "Chưa điền đù điểm,\nvui lòng kiểm tra lại!\n Lỗi ở ô $loi");
              } else if (err == true) {
                showNoti(context,
                    "Điểm chỉ được nhập giá trị 1 hoặc 2,\nvui lòng kiểm tra lại!\n Lỗi ở ô $loi");
              } else {
                guiDiem();
                createNoidungPhieu(diem);
                send = phieuToJson(Phieu(
                    title: "Kiểm tra ATVSLĐ tháng $thangHienTai - $tendv",
                    noidung: cacnoidungphieu,
                    donviId: iddonvi.toString(),
                    userId: uid));
                RemoteServiceTaoPhieu().taoPhieu(send);
                if (errorPost) {
                  errmsg(context, "Có lỗi xảy ra, vui lòng thử lại sau");
                } else {
                  showResult(context, "KiemTra");
                }
              }
            },
            child: const Text("Gửi"))
      ]),
    );
  }
}

class ThamDinhScreen extends StatefulWidget {
  const ThamDinhScreen({super.key});

  @override
  State<ThamDinhScreen> createState() => _ThamDinhScreenState();
}

class _ThamDinhScreenState extends State<ThamDinhScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  donvi(String tendonvi, int id) {
    return TextButton(
        onPressed: () {
          tendv = tendonvi;
          iddonvi = id;
          Navigator.pushNamed(context, '/ThamDinhChiTiet');
        },
        child: Text(tendonvi));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thẩm định đánh giá'),
      ),
      drawer: const NavigationDrawer1(),
      body: Column(children: [
        const SizedBox(height: 20),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: DataTable2(
                    columnSpacing: 1,
                    horizontalMargin: 1,
                    minWidth: 300,
                    columns: const [
                      DataColumn2(
                        label: Text('Chọn đơn vị để chấm điểm thẩm định'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        donvicon!.length,
                        (index) => DataRow(cells: [
                              DataCell(
                                donvi(donvicon![index].tenDv,
                                    donvicon![index].id),
                              )
                            ]))))),
        const SizedBox(
          height: 5,
        ),
      ]),
    );
  }
}

class KiemTra extends StatefulWidget {
  const KiemTra({super.key});

  @override
  State<KiemTra> createState() => _KiemTraState();
}

class _KiemTraState extends State<KiemTra> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  donvi(String tendonvi, int id) {
    return TextButton(
        onPressed: () {
          tendv = tendonvi;
          iddonvi = id;
          kyid = thangHienTai;
          Navigator.pushNamed(context, '/KiemTraKy');
        },
        child: Text(tendonvi));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kiểm tra ATVSLĐ'),
      ),
      drawer: const NavigationDrawer1(),
      body: Column(children: [
        const SizedBox(height: 20),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: DataTable2(
                    columnSpacing: 1,
                    horizontalMargin: 1,
                    minWidth: 50,
                    columns: const [
                      DataColumn2(
                        label: Text('Chọn đơn vị để tạo phiếu đánh giá'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        donvicon!.length,
                        (index) => DataRow(cells: [
                              DataCell(
                                donvi(donvicon![index].tenDv,
                                    donvicon![index].id),
                              )
                            ]))))),
        const Text('Danh sách phiếu đã gửi'),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: DataTable2(
                    columnSpacing: 1,
                    horizontalMargin: 1,
                    // minWidth: 150,
                    dataRowHeight: 70,
                    columns: const [
                      DataColumn2(
                        label: Text('STT'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Tên phiếu'),
                      ),
                      DataColumn2(
                        label: Text(
                          'Đánh giá cho',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DataColumn2(
                        label: Text('Ngày gửi', style: TextStyle(fontSize: 12)),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label:
                            Text('Người gửi', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        phieus!.length,
                        (index) => DataRow(cells: [
                              DataCell(Text((index + 1).toString())),
                              DataCell(TextButton(
                                  onPressed: () {
                                    idphieu = phieus![index].id.toString();
                                    getPhieu();
                                    stt=0;
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      Navigator.pushNamed(context, '/XemPhieu');
                                    });
                                  },
                                  child: Text(
                                    phieus![index].title,
                                    style: const TextStyle(fontSize: 9),
                                  ))),
                              DataCell(Text(phieus![index].donvi.tenDv)),
                              DataCell(Text(
                                  DateFormat('dd-MM-yy HH:mm').format(
                                      phieus![index]
                                          .createdAt
                                          .add(const Duration(hours: 7))),
                                  style: const TextStyle(fontSize: 12))),
                              DataCell(Text(phieus![index].user.name,
                                  style: const TextStyle(fontSize: 12))),
                            ]))))),
        const SizedBox(
          height: 5,
        ),
      ]),
    );
  }
}

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá an toàn vệ sinh lao động'),
      ),
      drawer: const NavigationDrawer1(),
      body: Column(children: [
        const SizedBox(height: 20),
        Text('Chọn kỳ đánh giá $donviuser'),
        const KySection(),
      ]),
    );
  }
}

class Rate extends StatefulWidget {
  const Rate({super.key});

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thẩm định đánh giá'),
      ),
      drawer: const NavigationDrawer1(),
      body: Column(children: [
        const SizedBox(height: 20),
        Text('Chọn kỳ đánh giá $tendv'),
        const RateSection(),
      ]),
    );
  }
}

doiTuongDanhGia(int index) {
  String dtdg = '';
  switch (index) {
    case 0:
    case 1:
      dtdg = "Phòng làm việc, phòng họp";
      break;
    case 2:
      dtdg = "Hành lang, cầu thang";
      break;
    case 3:
      dtdg = "Sàn, tường, trần nhà";
      break;
    case 4:
      dtdg = "Nhà vệ sinh";
      break;
    case 5:
      dtdg = "Khu vực để xe";
      break;
    case 6:
      dtdg = "Khuôn viên khu vực làm việc";
      break;
    case 7:
      dtdg = "Trang thiết bị, dụng cụ SX";
      break;
    case 8:
      dtdg = "Hệ thống điện";
      break;
    case 9:
      dtdg = "Phong trào 5S";
      break;
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
    case 15:
      dtdg = "Bên ngoài, trong nhà kho";
      break;
    case 16:
    case 17:
    case 18:
    case 19:
      dtdg = "Nhà máy nổ";
      break;
    case 20:
    case 21:
    case 22:
      dtdg = "Bên ngoài trạm";
      break;
    case 23:
    case 24:
    case 25:
    case 26:
      dtdg = "Bên trong trạm";
      break;
    case 27:
      dtdg = "Nhà máy nổ";
      break;
    case 28:
    case 29:
      dtdg = "Tuyến cột, cáp AC, cáp quang đến trạm";
      break;
    case 30:
    case 31:
    case 32:
    case 33:
      dtdg = "Cáp trên tuyến";
      break;
    case 34:
    case 35:
    case 36:
    case 37:
      dtdg = "Tủ/ Hộp";
      break;
    case 38:
      dtdg = "Tuyến cột";
      break;
    case 39:
      dtdg = "Tuyến cống, bể cáp";
      break;
    case 40:
    case 41:
    case 42:
    case 43:
    case 44:
    case 45:
    case 46:
      dtdg = "Trang bị BHLĐ, CCDC cho NLĐ";
      break;
    case 47:
    case 48:
    case 49:
      dtdg = "Quản lý xe ô tô";
      break;
  }
  return Text(dtdg);
}
