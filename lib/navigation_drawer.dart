import 'package:atvs/phieu_da_tao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:atvs/login.dart';
import 'package:atvs/section.dart';
import 'package:atvs/screen.dart';
import 'donvi.dart';

class NavigationDrawer1 extends StatelessWidget {
  const NavigationDrawer1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child:
                // Text('')
                rolename(roleid),
              ),
            ),
            ListTile(
              onTap: () {
                // print(roleid);
                Navigator.pushNamed(context, '/home');
              },
              leading: const Icon(Icons.home),
              title: const Text('Trang chủ'),
            ),
            ListTile(
              onTap: () {
                clearDiem();
                stt=0;
                Navigator.pushNamed(context, '/review');
              },
              leading: const Icon(Icons.reviews_outlined),
              title: const Text('Đánh giá ATVSLĐ'),
            ),
            ListTile(
              onTap: () {
                stt=0;
                clearDiem();
                getDonViCon();
                Navigator.pushNamed(context, '/ThamDinh');
              },
              leading: const Icon(Icons.rate_review),
              title: const Text('Thẩm định đánh giá'),
            ),
            ListTile(
              onTap: () {
                stt=0;
                clearDiem();
                getDonViCon();
                getPhieuDaTao();
                Future.delayed(
                    const Duration(milliseconds: 500), () {
                  Navigator.pushNamed(context, '/KiemTra');
                });

              },
              leading: const Icon(Icons.check),
              title: const Text('Kiểm tra ATVSLĐ'),
            ),
            ListTile(
              onTap: () {
                fullname = "";
                uid = "";
                roleid = "0";
                sdt ="";
                if (luuDangNhap == false) {
                  userNameCtl.clear();
                  passWordCtl.clear();
                }
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (Route<dynamic> route) => false);
              },
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất'),
            ),
            ListTile(
              onTap: () => SystemNavigator.pop(),
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Thoát ứng dụng'),
            ),
          ],
        ),
      ),
    );
  }
}

rolename(String roleid) {
  String role = '';
  switch (roleid) {
    case '1':
      role = "Nhân viên";
      break;
    case '2':
      role = "Nhân viên hỗ trợ";
      break;
    case '3':
      role = "Quản lý";
      break;
  }
  return Text(
    'Xin chào, ${fullname.toString()}!',
    style: const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
    textAlign: TextAlign.center,
  );
}

