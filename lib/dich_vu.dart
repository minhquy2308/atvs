// To parse this JSON data, do
//
//     final dichVu = dichVuFromJson(jsonString);
import 'package:http/http.dart' as http;
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:atvs/login.dart';
import 'package:atvs/remote_service.dart';
import 'package:data_table_2/data_table_2.dart';

String phpurl = "https://quytm.000webhostapp.com/database_flutter/";
var isLoaded = false;
var dichVuID = "";
String dropdownValue = listDichVu.first;
final List<String> listDichVu = [];
List<String> indexlistDichVu = [];
List<String> listFilter = [];
List<String> listTrangThaiNgheMay = ["1. Nghe máy", "2. Không nghe máy", "3. Thành công"];
List<DichVu>? cacdichvu;

List<DichVu> dichVuFromJson(String str) =>
    List<DichVu>.from(json.decode(str).map((x) => DichVu.fromJson(x)));

String dichVuToJson(List<DichVu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DichVu {
  DichVu({
    required this.id,
    required this.tenDichvu,
  });

  String id;
  String tenDichvu;

  factory DichVu.fromJson(Map<String, dynamic> json) => DichVu(
        id: json["id"],
        tenDichvu: json["ten_dichvu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ten_dichvu": tenDichvu,
      };
}

getDichVu() async {
  cacdichvu = await RemoteServiceDichVu().getDichVu();
  var soLuongDichVu = cacdichvu!.length;
  for (var i = 0; i < soLuongDichVu; i++) {
    listDichVu.add("${cacdichvu![i].id}. ${cacdichvu![i].tenDichvu}");
  }
  listFilter = LinkedHashSet<String>.from(listDichVu).toList();
}

class DanhMucDichVuDropdown extends StatefulWidget {
  const DanhMucDichVuDropdown({super.key});

  @override
  State<DanhMucDichVuDropdown> createState() => _DanhMucDichVuDropdownState();
}

class _DanhMucDichVuDropdownState extends State<DanhMucDichVuDropdown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: listFilter.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DanhMucDichvu extends StatefulWidget {
  const DanhMucDichvu({super.key});

  @override
  State<DanhMucDichvu> createState() => _DanhMucDichvuState();
}

class _DanhMucDichvuState extends State<DanhMucDichvu> {
  TextEditingController tenDichVuctl = TextEditingController();

  @override
  void initState() {
    error = false;
    sending = false;
    success = true;
    msg = "";
    super.initState();
  }

  late bool error, sending, success;
  late String msg;
  String phpurldel = "${phpurl}deletedichvu.php";
  String phpurlupdate = "${phpurl}updatedichvu.php";

  Future<void> deleteData() async {
    var res = await http.post(Uri.parse(phpurldel), body: {
      "id": dichVuID,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
          errmsg(context, msg);
        });
      } else {
        //after write success, make fields empty
        getDichVu();
        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Có lỗi khi thực hiện gửi dữ liệu.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  Future<void> updateData() async {
    var res = await http.post(Uri.parse(phpurlupdate), body: {
      "id": dichVuID,
      "ten_dichvu": tenDichVuctl.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      } else {
        //after write success, make fields empty
        getDichVu();
        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Có lỗi khi thực hiện gửi dữ liệu.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
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
            DataColumn2(
              label: Text('ID'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Tên dịch vụ'),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('Sửa'),
            ),
            DataColumn(
              label: Text('Xoá'),
            ),
          ],
          rows: List<DataRow>.generate(
              cacdichvu!.length,
              (index) => DataRow(cells: [
                    DataCell(Text(cacdichvu![index].id)),
                    DataCell(Text(cacdichvu![index].tenDichvu)),
                    DataCell(IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        dichVuID = cacdichvu![index].id;
                        tenDichVuctl.text = cacdichvu![index].tenDichvu;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              insetPadding: const EdgeInsets.symmetric(horizontal: 100),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              elevation: 16,
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  Center(
                                      child: Text('Sửa dịch vụ ID: $dichVuID')),
                                  // const SizedBox(height: 20),
                                  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextField(
                                        controller: tenDichVuctl,
                                        decoration: const InputDecoration(
                                          labelText: "Tên dịch vụ:",
                                        ),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.all(20),
                                      child: SizedBox(
                                          width: double.infinity,
                                          child: Center(
                                              child: ElevatedButton(
                                            onPressed: () {
                                              if (tenDichVuctl
                                                  .text.isNotEmpty) {
                                                //if button is pressed, setstate sending = true, so that we can show "sending..."
                                                setState(() {
                                                  sending = true;
                                                });
                                                updateData();
                                                if (success) {
                                                  getDichVu();
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 1), () {
                                                    showResult(
                                                        context, 'DanhMucDV');
                                                  });
                                                }
                                              } else {
                                                showNoti(context,
                                                    'Không được để nội dung trống!');
                                              }
                                            },
                                            child: Text(
                                              sending
                                                  ? "Đang thực hiện..."
                                                  : "Cập nhật",
                                              //if sending == true then show "Sending" else show "SEND DATA";
                                            ),
                                            //background of button is darker color, so set brightness to dark
                                          )))),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )),
                    DataCell(IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        dichVuID = cacdichvu![index].id;
                        deleteData();
                        if(success) {
                          var snackBar = const SnackBar(
                            duration: Duration(microseconds: 3000),
                            content: Text('Xoá thành công!'),
                          );
                          getDichVu();
                          Future.delayed(const Duration(seconds: 1), () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);
                          });
                        }
                        setState(() {
                          sending = false;
                        });
                      },
                    )),
                  ]))),
    ));
  }
}

showResult(BuildContext context, String route) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 16,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const SizedBox(height: 20),
            const Center(child: Text('Kết quả')),
            const SizedBox(height: 10),
            const Center(child: Text("Cập nhật thành công")),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      getDichVu();
                      Navigator.pushNamed(context, '/$route');
                    },
                    child: const Text("OK")))
          ],
        ),
      );
    },
  );
}

showNoti(BuildContext context, String noti) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 16,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const SizedBox(height: 20),
            const Center(child: Text('Thông báo')),
            const SizedBox(height: 10),
            Center(child: Text(noti)),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK")))
          ],
        ),
      );
    },
  );
}

class SuaDVSection extends StatefulWidget {
  const SuaDVSection(dichvuID, {super.key, required String id});

  @override
  State<SuaDVSection> createState() => _SuaDVSectionState();
}

class _SuaDVSectionState extends State<SuaDVSection> {
  TextEditingController tenDichVuctl = TextEditingController();
  late bool error, sending, success;
  late String msg;

  String phpurlupdate = "${phpurl}updatedichvu.php";

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(phpurlupdate), body: {
      "id": dichVuID,
      "ten_dichvu": tenDichVuctl.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      } else {
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Có lỗi khi thực hiện gửi dữ liệu.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        //enable scrolling, when keyboard appears,
        // hight becomes small, so prevent overflow
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(error ? msg : "Nhập tên dịch vụ"),

                // Text(success ? "Thêm thành công" : ""),

                TextField(
                  controller: tenDichVuctl,
                  decoration: const InputDecoration(
                    labelText: "Tên dịch vụ:",
                  ),
                ), //text input for name
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (tenDichVuctl.text.isNotEmpty) {
                              //if button is pressed, setstate sending = true, so that we can show "sending..."
                              setState(() {
                                sending = true;
                              });
                              sendData();
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Không được để nội dung trống!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            if (success) {
                              const snackBar = SnackBar(
                                content: Text('Thêm thành công dịch vụ'),
                              );
                              Future.delayed(const Duration(seconds: 1), () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            }
                          },
                          child: Text(
                            sending ? "Đang thực hiện..." : "Thêm",
                            //if sending == true then show "Sending" else show "SEND DATA";
                          ),
                          //background of button is darker color, so set brightness to dark
                        )))
              ],
            )));
  }
}
