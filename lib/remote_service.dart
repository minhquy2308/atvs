import 'package:atvs/tieu_chi.dart';
import 'package:http/http.dart' as http;
import 'baocao.dart';
import 'chi_tiet_tieu_chi.dart';
import 'danh_muc.dart';
import 'diem_chi_tiet.dart';
import 'login.dart';
import 'noi_dung.dart';
import 'user.dart';

var client = http.Client();


// class RemoteServiceUser {
//   Future<List<User>?> getUser() async {
//     var uri = Uri.parse('${phpurl}getalluser.php');
//     var respond = await client.get(uri);
//     if (respond.statusCode == 200) {
//       var json = respond.body;
//       return userFromJson(json);
//     }
//     return null;
//   }
// }

class RemoteServiceBaoCao {
  Future<List<Thang>?> getBaoCao() async {
    var uri = Uri.parse("https://atvs.vnptsonla.com/api/baocao_tonghop");
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return baocaoFromJson(json);
    }
    return null;
  }
}

class RemoteServiceDiemChiTiet {
  Future<List<DiemChiTiet?>?> getDiemChiTiet(String donvi, String ky) async {
    var uri = Uri.parse('https://atvs.vnptsonla.com/api/ketqua/filter?donvi_id=$donvi&ky_id=$ky');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return diemChiTietFromJson(json);
    }
    return null;
  }
}
class RemoteServiceDanhMuc {
  Future<List<DanhMuc?>?> getDanhMuc() async {
    var uri = Uri.parse('https://atvs.vnptsonla.com/api/dm_tieuchi');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return danhMucFromJson(json);
    }
    return null;
  }
}
class RemoteServiceChiTietTieuChi {
  Future<List<ChiTietTieuChi?>?> getChiTietTieuChi() async {
    var uri = Uri.parse('https://atvs.vnptsonla.com/api/dm_chitiettieuchi');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return chiTietTieuChiFromJson(json);
    }
    return null;
  }
}
class RemoteServiceNoiDung {
  Future<List<NoiDung?>?> getNoiDung() async {
    var uri = Uri.parse('https://atvs.vnptsonla.com/api/dm_noidung');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return noiDungFromJson(json);
    }
    return null;
  }
}
class RemoteServiceTieuChi {
  Future<List<TieuChi>?> getTieuChi() async {
    var uri = Uri.parse('https://atvs.vnptsonla.com/api/dm_tieuchi');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return tieuChiFromJson(json);
    }
    return null;
  }
}