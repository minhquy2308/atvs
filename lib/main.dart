import 'package:atvs/baocaotonghop.dart';
import 'package:atvs/phieu_da_tao.dart';
import 'package:atvs/section.dart';
import 'package:atvs/tieu_chi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'chi_tiet_tieu_chi.dart';
import 'danh_muc.dart';
import 'donvi.dart';
import 'login.dart';
import 'noi_dung.dart';
import 'screen.dart';

final List<String> dv = [];

Future main() async {
  getBaocao();
  getDanhMuc();
  getChiTietTieuChi();
  getNoiDung();
  getTieuChi();
  getDonVi();
  getPhieuDaTao();
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
            '/review': (context) => const Review(),
            '/reviewky': (context) => const ReviewKy(),
            '/ChiTiet': (context) => const ChiTiet(),
            '/ThamDinh': (context) => const ThamDinhScreen(),
            '/ThamDinhChiTiet': (context) => const Rate(),
            '/ThamDinhKy': (context) => const RateKy(),
            '/KiemTra': (context) => const KiemTra(),
            '/KiemTraKy': (context) => const KiemTraKy(),
            '/XemPhieu': (context) => const XemPhieu(),
          },
        ),
      ));
}
