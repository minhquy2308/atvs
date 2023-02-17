import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:atvs/login.dart';
import 'package:atvs/section.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

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
                // print(roleid);
                Navigator.pushNamed(context, '/review');
              },
              leading: const Icon(Icons.reviews_outlined),
              title: const Text('Đánh giá ATVSLĐ'),
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
      role = "Quản trị viên";
      break;
    case '2':
      role = "Nhân viên hỗ trợ";
      break;
    case '3':
      role = "Nhân viên CSKH";
      break;
  }
  return Text(
    'Xin chào, ${fullname.toString()}!\n$role',
    style: const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
    textAlign: TextAlign.center,
  );
}
