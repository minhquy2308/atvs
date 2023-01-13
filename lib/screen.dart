import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:atvs/dich_vu.dart';
import 'ho_tro.dart';
import 'section.dart';
import 'navigation_drawer.dart';
import 'user.dart';
import 'ketqua.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khảo sát CNTT'),
      ),
      drawer: const NavigationDrawer(),
      body: CustomScrollView(
    slivers: [
    SliverFillRemaining(
    hasScrollBody: false,
      child:
      Column(mainAxisSize: MainAxisSize.max, children: const [
        ImageSection(),
        WelcomeSection(),
        Spacer(),
        CreditSection(),
      ]),
    )]));
  }
}

class KhaoSatDVScreen extends StatelessWidget {
  const KhaoSatDVScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Báo cáo tổng hợp"),
        ),
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: const [
            BaoCaoTongHopSection(),
          ]),
        ));
  }
}

class BaoCaoTongHopScreen extends StatefulWidget {
  const BaoCaoTongHopScreen({super.key});

  @override
  State<BaoCaoTongHopScreen> createState() => _BaoCaoTongHopScreenState();
}

class _BaoCaoTongHopScreenState extends State<BaoCaoTongHopScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Báo cáo tổng hợp"),
        ),
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: const [
            BaoCaoTongHopSection(),
          ]),
        ));
  }
}

class BaoCaoChiTietScreen extends StatefulWidget {
  const BaoCaoChiTietScreen({super.key});

  @override
  State<BaoCaoChiTietScreen> createState() => _BaoCaoChiTietScreenState();
}

class _BaoCaoChiTietScreenState extends State<BaoCaoChiTietScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Báo cáo chi tiết cuộc gọi"),
        ),
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: const [
            BaoCaoChiTietSection(),
          ]),
        ));
  }
}

class CuocGoiHoTroScreen extends StatefulWidget {
  const CuocGoiHoTroScreen({super.key});

  @override
  State<CuocGoiHoTroScreen> createState() => _CuocGoiHoTroScreenState();
}

class _CuocGoiHoTroScreenState extends State<CuocGoiHoTroScreen> {
  @override
  void initState() {
    getDichVu();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // if(isLoaded == false){
    //   getDichVu();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Thêm mới cuộc gọi"),
        ),
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: const [
            CuocGoiHoTroSection(),
          ]),
        ));
  }
}
class GoiKiemScreen extends StatefulWidget {
  const GoiKiemScreen({super.key});

  @override
  State<GoiKiemScreen> createState() => _GoiKiemScreenState();
}

class _GoiKiemScreenState extends State<GoiKiemScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // if(isLoaded == false){
    //   getDichVu();
    // }
  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // if(isLoaded == false){
    //   getDichVu();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Gọi kiểm"),
        ),
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: const [
            GoiKiemSection(),
          ]),
        ));
  }
}

class KetQuaScreen extends StatefulWidget {
  const KetQuaScreen({super.key});

  @override
  State<KetQuaScreen> createState() => _KetQuaScreennState();
}

class _KetQuaScreennState extends State<KetQuaScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Khảo sát dịch vụ'),
        ),
        drawer: const NavigationDrawer(),
        body: Column(
            children: const [KetQuaSection()]));
  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

class DanhMucDVScreen extends StatefulWidget {
  const DanhMucDVScreen({super.key});

  @override
  State<DanhMucDVScreen> createState() => _DanhMucDVScreenState();
}

class _DanhMucDVScreenState extends State<DanhMucDVScreen> {
  @override
  void initState() {
    getDichVu();
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
          title: const Text('Quản lý dịch vụ'),
        ),
        drawer: const NavigationDrawer(),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ThemDV');
                  },
                  child: const Text('Thêm mới'),
                ))),
            const DanhMucDichvu()
          ],
        ));
  }
}
class ThemDVScreen extends StatefulWidget {
  const ThemDVScreen({super.key});

  @override
  State<ThemDVScreen> createState() => _ThemDVScreenState();
}

class _ThemDVScreenState extends State<ThemDVScreen> {
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
          title: const Text('Thêm mới dịch vụ'),
        ),
        drawer: const NavigationDrawer(),
        body: Column(
          children: const [
            ThemDVSection()
          ],
        ));
  }
}
class ThemUserScreen extends StatefulWidget {
  const ThemUserScreen({super.key});

  @override
  State<ThemUserScreen> createState() => _ThemUserScreenState();
}

class _ThemUserScreenState extends State<ThemUserScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thêm mới người dùng'),
        ),
        drawer: const NavigationDrawer(),
        body: Column(
          children: const [
            ThemUserSection()
          ],
        ));
  }
}
class GanUserScreen extends StatefulWidget {
  const GanUserScreen({super.key});

  @override
  State<GanUserScreen> createState() => _GanUserScreenState();
}

class _GanUserScreenState extends State<GanUserScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Phân quyền người dùng'),
        ),
        drawer: const NavigationDrawer(),
        body: Column(
          children: const [
            ThemUserSection()
          ],
        ));
  }
}
class DanhSachCuocGoiScreen extends StatefulWidget {
  const DanhSachCuocGoiScreen({super.key});

  @override
  State<DanhSachCuocGoiScreen> createState() => _DanhSachCuocGoiScreenState();
}

class _DanhSachCuocGoiScreenState extends State<DanhSachCuocGoiScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách cuộc gọi'),
        ),
        drawer: const NavigationDrawer(),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/CuocGoiHoTro');
                      },
                      child: const Text('Thêm mới'),
                    ))),
            const DanhSachCuocGoi()
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void initState() {
    getHotros();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
  }
}
class NHCauHoiScreen extends StatefulWidget {
  const NHCauHoiScreen({super.key});

  @override
  State<NHCauHoiScreen> createState() => _NHCauHoiScreenState();
}

class _NHCauHoiScreenState extends State<NHCauHoiScreen> {
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
          title: const Text('Ngân hàng câu hỏi'),
        ),
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: const [
            NHCauHoiSection(),
          ]),
        ));
  }
}

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quản trị tài khoản'),
        ),
        drawer: const NavigationDrawer(),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/ThemUser');
                      },
                      child: const Text('Thêm mới'),
                    ))),
            const AdminSection()
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    getUser();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
}