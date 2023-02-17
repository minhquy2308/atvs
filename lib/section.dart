import 'package:atvs/login.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

final now = DateTime.now();
final aMonthAgo = DateTime(now.year, now.month - 1, now.day);
int chonThang = 0, lechNam = 0, lechThang = 0;

List<String> listThang = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12'
];
List<String> listNam = ['2022', '2023'];
List<int> points = [];
List<String> listDiem = ['1', '2'];
List<String> listDiemDropdown = [];
int namHienTai = aMonthAgo.year, thangHienTai = aMonthAgo.month;
String dropdownNamValue = namHienTai.toString();
String dropdownThangValue = thangHienTai.toString();
bool check = true;

class ThangNam extends StatefulWidget {
  const ThangNam({super.key});

  @override
  State<ThangNam> createState() => _ThangNamState();
}

class _ThangNamState extends State<ThangNam> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        const Text('Năm:'),
        const SizedBox(width: 2),
        const Expanded(child: DropdownNam()),
        const Text('Tháng:'),
        const SizedBox(width: 2),
        const Expanded(child: DropdownThang()),
        Expanded(
            child: ElevatedButton(onPressed: () {
              lechNam = int.parse(aMonthAgo.year.toString()) - int.parse(dropdownNamValue);
              lechThang = int.parse(aMonthAgo.month.toString()) - int.parse(dropdownThangValue);
              if(lechNam * 12 + lechThang >=0){
                chonThang = lechNam * 12 + lechThang;
                Navigator.pushNamed(context, '/home');
              }else{
                showNoti(context, "Tháng bạn chọn không hợp lệ,\nvui lòng thử lại!");
              }

            }, child: const Text('Chọn'))),
        const SizedBox(width: 10),
      ],
    );
  }
}

class DropdownNam extends StatefulWidget {
  const DropdownNam({super.key});

  @override
  State<DropdownNam> createState() => _DropdownNamState();
}

class _DropdownNamState extends State<DropdownNam> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownNamValue,
      icon: const Icon(Icons.arrow_drop_down),
      // elevation: 5,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 0,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownNamValue = value!;
        });
      },
      items: listNam.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropdownDiem extends StatefulWidget {
  const DropdownDiem({super.key});

  @override
  State<DropdownDiem> createState() => _DropdownDiemState();
}

class _DropdownDiemState extends State<DropdownDiem> {
  dropDiem(int index) {
    return DropdownButton<String>(
      value: listDiemDropdown[index],
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 0,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          listDiemDropdown[index] = value!;
        });
      },
      items: listDiem.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownNamValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 0,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownNamValue = value!;
        });
      },
      items: listDiem.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropdownThang extends StatefulWidget {
  const DropdownThang({super.key});

  @override
  State<DropdownThang> createState() => _DropdownThangState();
}

class _DropdownThangState extends State<DropdownThang> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownThangValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 0,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownThangValue = value!;
        });
      },
      items: listThang.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class KySection extends StatefulWidget {
  const KySection({super.key});

  @override
  State<KySection> createState() => _KySectionState();
}

class _KySectionState extends State<KySection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
          columnSpacing: 1,
          horizontalMargin: 1,
          minWidth: 300,
          columns: [
            DataColumn2(
              label: Text('Danh sách kỳ năm $namHienTai'),
            ),
          ],
          rows: List<DataRow>.generate(
              thangHienTai,
              (index) => DataRow(cells: [
                    DataCell(
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/reviewky');
                        },
                        child: Text('Đánh giá, chấm điểm tháng ${index + 1}'),
                      ),
                    )
                  ]))),
    ));
  }
}

class CreditSection extends StatefulWidget {
  const CreditSection({super.key});

  @override
  State<CreditSection> createState() => _CreditSectionState();
}

class _CreditSectionState extends State<CreditSection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: const <Widget>[
          Text('Hệ thống đánh giá \nAn toàn vệ sinh lao động - VNPT Sơn La',
              textAlign: TextAlign.center),
          Text('Copyright © VNPT Sơn La'),
        ]),
      ),
    );
  }
}

TextEditingController userNameCtl = TextEditingController();
TextEditingController passWordCtl = TextEditingController();

field(TextEditingController controller, Icon icon, String label) {
  return Container(
    decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.blue)),
    child: TextField(
        controller: controller,
        //onChanged: onchange,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 8, left: 20),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
          suffixIcon: icon,
          labelText: label,
          labelStyle:
              const TextStyle(fontSize: 14, decoration: TextDecoration.none),
        )),
  );
}

fieldpw(TextEditingController controller, Icon icon, String label) {
  return Container(
    decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.blue)),
    child: TextField(
        controller: controller,
        //onChanged: onchange,
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 8, left: 20),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
          suffixIcon: icon,
          labelText: label,
          labelStyle:
              const TextStyle(fontSize: 14, decoration: TextDecoration.none),
        )),
  );
}

class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // const SizedBox(height: 10),
        field(userNameCtl, const Icon(Icons.email_outlined),
            "Tên đăng nhập (Email tập đoàn bỏ @vnpt.vn)"),
        const SizedBox(
          height: 10,
        ),
        fieldpw(passWordCtl, const Icon(Icons.lock), "Mật khẩu"),
      ]),
    );
  }
}

class ImageSection extends StatefulWidget {
  const ImageSection({super.key});

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/vnpt.jpg',
      width: 400,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}

validate(BuildContext context) {
  if (1 == 1) {
    check = false;
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
              const Center(child: Text("Chưa nhập đủ thông tin!")),
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
    check = true;
  }
}
