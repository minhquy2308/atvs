import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:atvs/dich_vu.dart';
import 'package:atvs/login.dart';
import 'package:atvs/section.dart';
import 'package:atvs/user.dart';
import 'package:atvs/ketqua.dart';
import 'ho_tro.dart';

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
                child: rolename(roleid),
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
            // ExpansionTile(
            //   leading: const Icon(Icons.analytics),
            //   title: const Text("Báo cáo"),
            //   children: <Widget>[
            //     ListTile(
            //       onTap: () {
            //         Navigator.pushNamed(context, '/BaoCaoTongHop');
            //       },
            //       leading: const Icon(Icons.list),
            //       title: const Text('Báo cáo tổng hợp'),
            //     ),
            //     ListTile(
            //       onTap: () {
            //         Navigator.pushNamed(context, '/BaoCaoChiTiet');
            //       },
            //       leading: const Icon(Icons.list),
            //       title: const Text('Báo cáo chi tiết gọi kiểm'),
            //     ),
            //   ],
            // ),
            ExpansionTile(
                leading: const Icon(Icons.phone),
                title: const Text('Hỗ trợ khách hàng'),
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      getDichVu();
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pushNamed(context, '/CuocGoiHoTro');
                      });
                    },
                    leading: const Icon(Icons.call_made),
                    title: const Text('Cuộc gọi hỗ trợ'),
                  ),
                  ListTile(
                    onTap: () {
                      getHotros();
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pushNamed(context, '/DanhSachCuocGoi');
                      });
                    },
                    leading: const Icon(Icons.list),
                    title: const Text('Danh sách cuộc gọi'),
                  ),
                ]),
            ListTile(
              onTap: () {
                getKetqua();
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushNamed(context, '/KetQua');
                });
              },
              leading: const Icon(Icons.work),
              title: const Text('Khảo sát dịch vụ'),
            ),
            if (roleid == '1')
              ExpansionTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Cấu hình'),
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        getDichVu();
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pushNamed(context, '/DanhMucDV');
                        });
                      },
                      leading: const Icon(Icons.rounded_corner),
                      title: const Text('Danh mục dịch vụ'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/NHCauHoi');
                      },
                      leading: const Icon(Icons.rounded_corner),
                      title: const Text('Ngân hàng câu hỏi'),
                    ),
                    ListTile(
                      onTap: () {
                        getUser();
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pushNamed(context, '/Admin');
                        });
                      },
                      leading: const Icon(Icons.rounded_corner),
                      title: const Text('Quản trị tài khoản'),
                    ),
                  ]),
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
