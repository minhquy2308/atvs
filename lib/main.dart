import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login.dart';
import 'screen.dart';

final List<String> dv = [];

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft
  ]).then((value) => runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ATVS VNPT',
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
            '/BaoCaoTongHop': (context) => const BaoCaoTongHopScreen(),
            '/BaoCaoChiTiet': (context) => const BaoCaoChiTietScreen(),
            '/CuocGoiHoTro': (context) => const CuocGoiHoTroScreen(),
            '/GoiKiem': (context) => const GoiKiemScreen(),
            '/DanhSachCuocGoi': (context) => const DanhSachCuocGoiScreen(),
            '/KetQua': (context) => const KetQuaScreen(),
            '/DanhMucDV': (context) => const DanhMucDVScreen(),
            '/ThemDV': (context) => const ThemDVScreen(),
            '/NHCauHoi': (context) => const NHCauHoiScreen(),
            '/Admin': (context) => const AdminScreen(),
            '/ThemUser': (context) => const ThemUserScreen(),
          },
        ),
      ));
}


