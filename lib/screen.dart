import 'package:atvs/tieu_chi.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'baocaotonghop.dart';
import 'diem_chi_tiet.dart';
import 'noi_dung.dart';
import 'section.dart';
import 'navigation_drawer.dart';
import 'user.dart';

var stt = 0;
List<TextEditingController> _controller = [
  for (int i = 1; i < 50; i++)
    TextEditingController()
];
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
                'Tự\nđánh\ngiá',style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              fixedWidth: 35,
            ),
            DataColumn2(
              label: Text(
                'Thẩm\nđịnh', style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              fixedWidth: 40,
            ),
            DataColumn2(
              label: Text('Chi tiết', style: TextStyle(fontSize: 12),),
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
      drawer: const NavigationDrawer(),
      body: Column(children: [
        // TextButton(onPressed: (){
        //
        // }, child: const Text('Test')),
        const ThangNam(),
        baoCao(chonThang),
        chuaThucHien(chonThang),
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
              '${tieuchis![stt].sothutu.toString()}. ${tieuchis![stt].tenDm.toString()} ', textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
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
                      'Đối tượng\nđánh giá', style: TextStyle(fontSize: 12),
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
                      'Điểm\nchỉ\ntiêu', style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    fixedWidth: 40,
                  ),
                  DataColumn2(
                    label: Text('Điểm\nđơn vị\nchấm', style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center),
                    fixedWidth: 40,
                  ),
                  DataColumn2(
                    label:
                        Text('Điểm\nthẩm\nđịnh', style: TextStyle(fontSize: 12),textAlign: TextAlign.center),
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
                          DataCell(Text(
                              (diemchitiets![index + stt * 10]
                                  .diemtothamdinh
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
        title: const Text('Điểm chi tiết đơn vị'),
      ),
      drawer: const NavigationDrawer(),
      body: Column(children: [
        diemChiTiet(stt),
        const SizedBox(height: 20),
        const SizedBox(
          height: 5,
        ),
        Padding(padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              const Text('Trang:'),
              TextButton(
                  onPressed: () {
                    stt = 0;
                    Navigator.pushNamed(context, '/ChiTiet');
                  },
                  child: stt == 0 ? const Text('1', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)) : const Text('1')),
              TextButton(
                  onPressed: () {
                    stt = 1;
                    Navigator.pushNamed(context, '/ChiTiet');
                  },
                  child: stt == 1 ? const Text('2', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)) : const Text('2')),
              TextButton(
                  onPressed: () {
                    stt = 2;
                    Navigator.pushNamed(context, '/ChiTiet');
                  },
                  child: stt == 2 ? const Text('3', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)) : const Text('3')),
              TextButton(
                  onPressed: () {
                    stt = 3;
                    Navigator.pushNamed(context, '/ChiTiet');
                  },
                  child: stt == 3 ? const Text('4', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)) : const Text('4')),
              TextButton(
                  onPressed: () {
                    stt = 4;
                    Navigator.pushNamed(context, '/ChiTiet');
                  },
                  child: stt == 4 ? const Text('5', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)) : const Text('5')),
            ],
          ),
        )
      ]),
    );
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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
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
                          'Đối tượng\nđánh giá', style: TextStyle(fontSize: 12),
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
                          'Điểm\nchỉ\ntiêu', style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        fixedWidth: 40,
                      ),
                      DataColumn2(
                        label: Text('Điểm\nđơn vị\nchấm', style: TextStyle(fontSize: 10),
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
                          DataCell(TextField(controller: _controller[index],)),
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
      drawer: const NavigationDrawer(),
      body: Column(children: [
        diemChiTiet(stt),
        const SizedBox(height: 20),
        const SizedBox(
          height: 5,
        ),
        Padding(padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Text('Trang:'),
              TextButton(
                  onPressed: () {
                    stt = 0;
                    Navigator.pushNamed(context, '/reviewky');
                  },
                  child: stt == 0 ? const Text('1', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)) : const Text('1')),
              TextButton(
                  onPressed: () {
                    stt = 1;
                    Navigator.pushNamed(context, '/reviewky');
                  },
                  child: stt == 1 ? const Text('2', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)) : const Text('2')),
              TextButton(
                  onPressed: () {
                    stt = 2;
                    Navigator.pushNamed(context, '/reviewky');
                  },
                  child: stt == 2 ? const Text('3', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)) : const Text('3')),
              TextButton(
                  onPressed: () {
                    stt = 3;
                    Navigator.pushNamed(context, '/reviewky');
                  },
                  child: stt == 3 ? const Text('4', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)) : const Text('4')),
              TextButton(
                  onPressed: () {
                    stt = 4;
                    Navigator.pushNamed(context, '/reviewky');
                  },
                  child: stt == 4 ? const Text('5', style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)) : const Text('5')),
            ],
          ),
        )
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
      drawer: const NavigationDrawer(),
      body: Column(children: const [
        SizedBox(height: 20),
        Text('Chọn kỳ đánh giá TTVT Thành Phố Sơn La'),
        KySection(),
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