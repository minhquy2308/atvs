import 'dich_vu.dart';
import 'package:http/http.dart' as http;
import 'ho_tro.dart';
import 'user.dart';
import 'ketqua.dart';

var client = http.Client();

class RemoteServiceDichVu {
  Future<List<DichVu>?> getDichVu() async {
    var uri = Uri.parse('${phpurl}getalldichvu.php');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return dichVuFromJson(json);
    }
    return null;
  }
}

class RemoteServiceUser {
  Future<List<User>?> getUser() async {
    var uri = Uri.parse('${phpurl}getalluser.php');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return userFromJson(json);
    }
    return null;
  }
}

class RemoteServiceHoTro {
  Future<List<HoTro>?> getHoTro() async {
    var uri = Uri.parse('${phpurl}getallcuocgoi.php');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return hoTroFromJson(json);
    }
    return null;
  }
}

class RemoteServiceKetQua {
  Future<List<Ketqua>?> getKetQua() async {
    var uri = Uri.parse('${phpurl}getkq.php');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return ketquaFromJson(json);
    }
    return null;
  }
}
