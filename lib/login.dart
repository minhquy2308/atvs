import 'dart:convert';
import 'package:atvs/baocaotonghop.dart';
import 'package:atvs/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'section.dart';

String phpurl = "https://quytm.000webhostapp.com/database_flutter/";
late String errormsg;
late bool error, showprogress, sending;
bool sso = false, luuDangNhap = true, otpAuth = false, success = false;
late String username, password, uid, msg, donviuser, donviiduser;
late String roleid;
String fullname = "", sdt = "";
String smsAPI =
    "4ec92041da13041fd2ad82cb9e158c25f5f96ce9iaGzrGdTsVJABbslcsQFCbkAR";
TextEditingController sdtUserCtl = TextEditingController();
TextEditingController otpCtl = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _loadLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userNameCtl.text = (prefs.getString('username') ?? "");
      passWordCtl.text = (prefs.getString('password') ?? "");
      luuDangNhap = prefs.getBool('save') ?? false;
      // sso = prefs.getBool('sso') ?? false;
      // otpAuth = prefs.getBool('otpAuth') ?? false;
      if (luuDangNhap) {
        setState(() {
          luuDangNhap = true;
        });
      }
    });
  }

  //Incrementing counter after click
  Future<void> _saveLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('username', userNameCtl.text);
      prefs.setString('password', passWordCtl.text);
      prefs.setBool('save', luuDangNhap);
      // prefs.setBool('otpAuth', otpAuth);
    });
  }

  @override
  void initState() {
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;
    _loadLoginInfo();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  startLoginSSO() async {
    String apiurl = "https://login.vnptsonla.com/api/ldap_login"; //api url
    var username = "${userNameCtl.text}@vnpt.vn";
    var response = await http.post(Uri.parse(apiurl), body: {
      'username': username, //get the username text
      'password': passWordCtl.text //get password text
    });

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["login"] == "success") {
        getUserInfo();
        setState(() {
          error = false;
          showprogress = false;
        });
      } else {
        if (jsondata["login"] == "fail") {
          setState(() {
            showprogress = false; //don't show progress indicator
            error = true;
            errormsg = "Sai email hoặc mật khẩu";
            error ? errmsg(context, errormsg) : const Dialog();
          });
        } else {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  checksdt() {
    sending = false;
    if (sdt.length < 10) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 16,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                const SizedBox(height: 20),
                const Center(child: Text('Thêm số điện thoại:')),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: TextField(
                      controller: sdtUserCtl,
                      decoration: const InputDecoration(
                        labelText: "SĐT:",
                      ),
                    )),
                const SizedBox(height: 20),
                const Center(
                    child: Text(
                  'Nhập số điện thoại của bạn và bỏ số 0 đầu tiên.\nVí dụ: 0889123169 -> 889123169',
                  textAlign: TextAlign.center,
                )),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: SizedBox(
                        width: double.infinity,
                        child: Center(
                            child: ElevatedButton(
                          onPressed: () {
                            if (sdtUserCtl.text.length == 9) {
                              //if button is pressed, setstate sending = true, so that we can show "sending..."
                              setState(() {
                                sending = true;
                              });
                              updateSDT();
                              if (success) {
                                Future.delayed(const Duration(seconds: 1), () {
                                  otpmsg(context,
                                      'Cập nhật số điện thoại thành công!');
                                });
                              }
                            } else {
                              showNoti(context, 'Số điện thoại không hợp lệ!');
                            }
                          },
                          child: Text(
                            sending ? "Đang thực hiện..." : "Cập nhật",
                            //if sending == true then show "Sending" else show "SEND DATA";
                          ),
                          //background of button is darker color, so set brightness to dark
                        )))),
              ],
            ),
          );
        },
      );
      if (mounted) {
        errmsg(context, "Vui lòng cập nhật số điện thoại để xác thực");
      }
    } else {
      sendOTP();
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 16,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Center(child: Text('Xác thực OTP')),
                  const SizedBox(height: 20),
                  Center(
                      child: Text(
                    "OTP đã gửi về số ${sdt.replaceAll('+84', '0')} của bạn.\nNếu số điện thoại trên không chính xác, \nliên hệ bộ phận hỗ trợ để cập nhật lại",
                    textAlign: TextAlign.center,
                  )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 100),
                      child: TextField(
                        controller: otpCtl,
                        decoration: const InputDecoration(
                          labelText: "OTP:",
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                          width: double.infinity,
                          child: Center(
                              child: ElevatedButton(
                            onPressed: () {
                              if (otpCtl.text.length == 6) {
                                //if button is pressed, setstate sending = true, so that we can show "sending..."
                                setState(() {
                                  sending = true;
                                });
                                verifyOTP();
                              } else {
                                errmsg(context,
                                    "OTP không hợp lệ! (Phải có 6 chữ số)");
                              }
                            },
                            child: Text(
                              sending ? "Đang thực hiện..." : "Xác thực",
                              //if sending == true then show "Sending" else show "SEND DATA";
                            ),
                            //background of button is darker color, so set brightness to dark
                          )))),
                ],
              ),
            );
          });
    }
  }

  Future<void> updateSDT() async {
    String sdtChuan = "+84${sdtUserCtl.text}";
    var res = await http.post(Uri.parse("${phpurl}updatesdt.php"), body: {
      "id": uid,
      "sdt": sdtChuan,
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
        sdt = sdtChuan;
        sdtUserCtl.clear();
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

  getUserInfo() async {
    String infourl = "https://atvs.vnptsonla.com/api/login"; //api url
    var response = await http.post(Uri.parse(infourl), body: {
      "username": userNameCtl.text, //get the username text
    });
    if (response.statusCode == 200) {
      var user = userFromJson(response.body);
      if (user.msg == "success") {
        uid = user.userInfo.userId.toString();
        fullname = user.userInfo.fullname;
        roleid = user.userInfo.roleId;
        donviuser = user.userInfo.tenDonvi;
        donviiduser = user.userInfo.donviId.toString();
        dropdownThangValue = baocaos![0].month.toString();
        if (listThang.isEmpty) {
          for (int i = 0; i < baocaos!.length; i++) {
            listThang.add(baocaos![i].month.toString());
          }
        }
        if (mounted) Navigator.pushNamed(context, '/home');
        setState(() {
          error = false;
          showprogress = false;
        });
        //save the data returned from server
        //and navigate to home page
        //user shared preference to save data
      } else {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Something went wrong.";
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  sendOTP() async {
    String sendOTPAPI = "https://textbelt.com/otp/generate"; //api url
    var response = await http.post(Uri.parse(sendOTPAPI), body: {
      'phone': sdt, //get the username text
      'userid': userNameCtl.text,
      'key': smsAPI,
    });

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      // print(jsondata);
      if (jsondata["success"]) {
        setState(() {
          error = false;
          showprogress = false;
        });
      } else {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Something went wrong.";
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  verifyOTP() async {
    String verifyOTPAPI =
        "https://textbelt.com/otp/verify?otp=${otpCtl.text}&userid=${userNameCtl.text}&key=$smsAPI";
    var response = await http.get(Uri.parse(verifyOTPAPI));
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["success"]) {
        setState(() {
          error = false;
          showprogress = false;
        });
        if (jsondata["isValidOtp"] == true) {
          otpCtl.clear();
          if (mounted) {
            Navigator.pushNamed(context, '/home');
          }
        }
        if (jsondata["isValidOtp"] == false) {
          otpCtl.clear();
          if (mounted) {
            errmsg(context, 'OTP không chính xác');
          }
          //OTP không chính xác
        }
      } else {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Something went wrong.";
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  // attempt to dispose controller when Widget is disposed
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Đánh giá An toàn vệ sinh lao động'),
      ),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ImageSection(),
              const LoginSection(),
              Container(
                padding: const EdgeInsets.all(2),
                // margin: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 40,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        //show progress indicator on click
                        showprogress = true;
                      });
                      if (luuDangNhap == true) {
                        _saveLoginInfo();
                      }
                      startLoginSSO();
                      // Navigator.pushNamed(context, '/home');
                    },
                    child: showprogress
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.orange[100],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.deepOrangeAccent),
                            ),
                          )
                        : const Text(
                            "Đăng nhập",
                            style: TextStyle(fontSize: 15),
                          ),
                    // if showprogress == true then show progress indicator
                    // else show "LOGIN NOW" text
                  ),
                ),
              ),
              // checkbox(),
              const LuuDangNhap(),
              const Spacer(),
              const CreditSection()
            ],
          ),
        ),
      ]),
    );
  }
}

class LuuDangNhap extends StatefulWidget {
  const LuuDangNhap({super.key});

  @override
  State<LuuDangNhap> createState() => _LuuDangNhapState();
}

class _LuuDangNhapState extends State<LuuDangNhap> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
              child: CheckboxListTile(
            title: const Text('Ghi nhớ thông tin đăng nhập'),
            checkColor: Colors.white,
            // fillColor: MaterialStateProperty.resolveWith(getColor),
            value: luuDangNhap,
            onChanged: (bool? value) {
              setState(() {
                luuDangNhap = value!;
              });
            },
          ))
        ]));
  }
}

class OTPCheckBox extends StatefulWidget {
  const OTPCheckBox({super.key});

  @override
  State<OTPCheckBox> createState() => _OTPCheckBoxState();
}

class _OTPCheckBoxState extends State<OTPCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Center(
          child: CheckboxListTile(
        title: const Text('Xác thực OTP'),
        checkColor: Colors.white,
        // fillColor: MaterialStateProperty.resolveWith(getColor),
        value: otpAuth,
        onChanged: (bool? value) {
          setState(() {
            otpAuth = value!;
          });
        },
      ))
    ]);
  }
}

errmsg(BuildContext context, String text) {
  //error message widget.
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 10,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              const SizedBox(height: 20),
              const Center(
                  child: Text(
                'Thông báo',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                    child: Text(
                  text,
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(height: 10),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK")))
            ],
          ),
        );
      });
}

otpmsg(BuildContext context, String text) {
  //error message widget.
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 10,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              const SizedBox(height: 20),
              const Center(
                  child: Text(
                'Thông báo',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 20),
              Center(child: Text(text)),
              const SizedBox(height: 10),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (Route<dynamic> route) => false);
                      },
                      child: const Text("OK")))
            ],
          ),
        );
      });
}

checkbox() {
  return Row(
    children: const [
      Expanded(
        flex: 5,
        child: OTPCheckBox(),
      ),
    ],
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
            Center(
                child: Text(
              noti,
              textAlign: TextAlign.center,
            )),
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
                      Navigator.pushNamed(context, '/$route');
                    },
                    child: const Text("OK")))
          ],
        ),
      );
    },
  );
}
