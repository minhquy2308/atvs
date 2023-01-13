// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);
import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:atvs/dich_vu.dart';
import 'package:atvs/login.dart';
import 'remote_service.dart';
import 'package:http/http.dart' as http;

late bool validate;
late String roleIDEdit;
var isLoaded = false;
List<User>? users;

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
  });

  String id;
  String name;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}

getUser() async {
  users = await RemoteServiceUser().getUser();
}

var error = false;
var sending = false;
var success = true;
var msg = "";
var phpurlUpdateUser = '${phpurl}updateuser.php';
var phpurlDelUser = '${phpurl}deleteuser.php';
var userID = "";
TextEditingController tenUserCtl = TextEditingController();
TextEditingController roleUserCtl = TextEditingController();
TextEditingController emailUserCtl = TextEditingController();
TextEditingController passwordUserCtl = TextEditingController();

class AdminSection extends StatefulWidget {
  const AdminSection({super.key});

  @override
  State<AdminSection> createState() => _AdminSectionState();
}

class _AdminSectionState extends State<AdminSection> {
  @override
  void initState() {
    super.initState();
    error = false;
    sending = false;
    success = true;
    msg = "";
  }

  Future<void> updateData() async {
    var res = await http.post(Uri.parse(phpurlUpdateUser), body: {
      "id": userID,
      "name": tenUserCtl.text,
      "email": emailUserCtl.text
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
        getUser();
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

  Future<void> updatePassword() async {
    var res = await http.post(Uri.parse('${phpurl}updateuserpw.php'), body: {
      "id": userID,
      "password": passwordUserCtl.text
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
        passwordUserCtl.clear();
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

  Future<void> updateRole() async {
    var res = await http.post(Uri.parse('${phpurl}updateroleuser.php'), body: {
      "id": userID,
      "role_id": roleUserCtl.text,
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
        roleUserCtl.clear();
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

  Future<void> deleteData() async {
    var res = await http.post(Uri.parse(phpurlDelUser), body: {
      "id": userID,
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
        getUser();
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

  Future<void> getRole() async {
    var res = await http.post(Uri.parse("${phpurl}getrole.php"), body: {
      "id": userID,
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
        roleIDEdit = data["role_id"];
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
              fixedWidth: 25,
            ),
            DataColumn2(
              label: Text('Họ và tên'),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text('Email'),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text(''),
              fixedWidth: 30,
            ),
            DataColumn2(
              label: Text(''),
              fixedWidth: 30,
            ),
            DataColumn2(
              label: Text(''),
              fixedWidth: 30,
            ),
            DataColumn2(
              label: Text(''),
              fixedWidth: 30,
            ),
          ],
          rows: List<DataRow>.generate(
              users!.length,
              (index) => DataRow(cells: [
                    DataCell(Text(users![index].id)),
                    DataCell(Text(users![index].name)),
                    DataCell(Text(users![index].email)),
                    DataCell(IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        userID = users![index].id;
                        tenUserCtl.text = users![index].name;
                        emailUserCtl.text = users![index].email;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              insetPadding: const EdgeInsets.symmetric(horizontal: 100),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              elevation: 16,
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  const SizedBox(height: 10),
                                  Center(
                                      child: Text('Sửa người dùng ID: $userID',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold))),
                                  // const SizedBox(height: 10),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: TextField(
                                        controller: tenUserCtl,
                                        decoration: const InputDecoration(
                                          labelText: "Họ và tên:",
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: TextField(
                                        controller: emailUserCtl,
                                        decoration: const InputDecoration(
                                          labelText: "Email:",
                                        ),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      child: SizedBox(
                                          width: double.infinity,
                                          child: Center(
                                              child: ElevatedButton(
                                            onPressed: () {
                                              validate = false;
                                              validateEdit(context);
                                              if (validate == true) {
                                                //if button is pressed, setstate sending = true, so that we can show "sending..."
                                                setState(() {
                                                  sending = true;
                                                });
                                                updateData();
                                                if (success) {
                                                  getUser();
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 1), () {
                                                    showResult(
                                                        context, 'Admin');
                                                  });
                                                }
                                              }
                                            },
                                            child: Text(
                                              sending
                                                  ? "Đang thực hiện..."
                                                  : "Lưu thay đổi",
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
                      icon: const Icon(Icons.perm_identity),
                      onPressed: () {
                        userID = users![index].id;
                        roleIDEdit = "Chưa gán quyền";
                        getRole();
                        Future.delayed(const Duration(seconds: 2), () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                insetPadding: const EdgeInsets.symmetric(horizontal: 100),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 16,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    // const SizedBox(height: 20),
                                    Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Center(
                                            child: Text(
                                                'Gán quyền cho user: \n${users![index].email}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold), textAlign: TextAlign.center,))),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Text(
                                            "Quyền hiện tại: $roleIDEdit")),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: TextField(
                                          controller: roleUserCtl,
                                          decoration: const InputDecoration(
                                            labelText:
                                                "Nhập số tương ứng với quyền muốn gán:",
                                          ),
                                        )),
                                    const SizedBox(height: 20),
                                    const Center(
                                      child: Text(
                                          '1. Quản trị\n2. Nhân viên hỗ trợ\n3. Nhân viên gọi kiểm'),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.all(10),
                                        child: SizedBox(
                                            width: double.infinity,
                                            child: Center(
                                                child: ElevatedButton(
                                              onPressed: () {
                                                validate = false;
                                                //if button is pressed, setstate sending = true, so that we can show "sending..."
                                                setState(() {
                                                  sending = true;
                                                });
                                                validateRole(context);
                                                if (validate == true) {
                                                  updateRole();
                                                  if (success) {
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 1), () {
                                                      showResult(
                                                          context, 'Admin');
                                                    });
                                                  }
                                                }
                                              },
                                              child: Text(
                                                sending
                                                    ? "Đang thực hiện..."
                                                    : "Thực hiện",
                                                //if sending == true then show "Sending" else show "SEND DATA";
                                              ),
                                              //background of button is darker color, so set brightness to dark
                                            )))),
                                  ],
                                ),
                              );
                            },
                          );
                        });
                      },
                    )),
                    DataCell(IconButton(
                      icon: const Icon(Icons.password),
                      onPressed: () {
                        userID = users![index].id;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              insetPadding: const EdgeInsets.symmetric(horizontal: 80),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 16,
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  // const SizedBox(height: 20),
                                  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                          child: Text(
                                              'Tạo mật khẩu mới cho user: \n${users![index].email}', textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold)))),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: TextField(
                                        controller: passwordUserCtl,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          labelText: "Mật khẩu:",
                                        ),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      child: SizedBox(
                                          width: double.infinity,
                                          child: Center(
                                              child: ElevatedButton(
                                            onPressed: () {
                                              //if button is pressed, setstate sending = true, so that we can show "sending..."
                                              setState(() {
                                                sending = true;
                                              });
                                              updatePassword();
                                              if (success) {
                                                Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  showResult(context, 'Admin');
                                                });
                                              }
                                            },
                                            child: Text(
                                              sending
                                                  ? "Đang thực hiện..."
                                                  : "Thực hiện",
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
                        userID = users![index].id;
                        deleteData();
                        if(error == false) {
                          getUser();
                          var snackBar = const SnackBar(
                            duration: Duration(microseconds: 3000),
                            content: Text('Xoá thành công!'),
                          );
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

validateRole(BuildContext context) {
  if (roleUserCtl.text == '1' ||
      roleUserCtl.text == '2' ||
      roleUserCtl.text == '3') {
    validate = true;
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 16,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              const SizedBox(height: 20),
              const Center(child: Text('Thông báo')),
              const SizedBox(height: 10),
              const Center(
                  child: Text("Chưa nhập đủ hoặc nhập sai thông tin!")),
              Center(
                  child: TextButton(
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
}

validateEdit(BuildContext context) {
  if (tenUserCtl.text.isNotEmpty || emailUserCtl.text.isNotEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 16,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              const SizedBox(height: 20),
              const Center(child: Text('Thông báo')),
              const SizedBox(height: 10),
              const Center(
                  child: Text("Chưa nhập đủ hoặc nhập sai thông tin!")),
              Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK")))
            ],
          ),
        );
      },
    );
  } else {
    validate = true;
  }
}
