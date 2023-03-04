import 'package:atvs/login.dart';
import 'package:atvs/phieu_da_tao.dart';
import 'package:atvs/section.dart';
import 'package:atvs/tieu_chi.dart';
import 'package:http/http.dart' as http;
import 'baocao.dart';
import 'chi_tiet_phieu.dart';
import 'chi_tiet_tieu_chi.dart';
import 'danh_muc.dart';
import 'diem_chi_tiet.dart';
import 'donvi.dart';
import 'noi_dung.dart';
import 'screen.dart';

var client = http.Client();
bool errorPost = false;

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
    var uri = Uri.parse(
        'https://atvs.vnptsonla.com/api/ketqua/filter?donvi_id=$donvi&ky_id=$ky');
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

class RemoteServiceDonVi {
  Future<List<Donvi>?> getDonVi() async {
    var uri = Uri.parse('https://atvs.vnptsonla.com/api/donvi');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return donviFromJson(json);
    }
    return null;
  }
}

class RemoteServiceKetQua {
  guiKetQua() async {
    var uri = Uri.parse('https://atvs.vnptsonla.com/api/ketqua');
    var respond = await client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: send);
    if (respond.statusCode == 200) {
      errorPost = false;
      clearDiem();
    } else {
      errorPost = true;
    }
  }
}

class RemoteServiceTaoPhieu {
  taoPhieu(String send) async {
    var uri = Uri.parse('https://atvs.vnptsonla.com/api/phieu');
    var respond = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: send);
    if (respond.statusCode == 200) {
      errorPost = false;
      clearDiem();
    } else {
      errorPost = true;
    }
  }
}

class RemoteServiceThamDinh {
  taoPhieu(String send) async {
    var uri =
        Uri.parse('https://atvs.vnptsonla.com/api/thamdinh/$kyid/$iddonvi');
    var respond = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: send);
    if (respond.statusCode == 200) {
      errorPost = false;
      clearDiem();
    } else {
      errorPost = true;
    }
  }
}

class RemoteServicePhieu {
  Future<List<PhieuDaTao>?> getPhieu() async {
    var uri = Uri.parse('https://atvs.vnptsonla.com/api/phieu');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return phieuDaTaoFromJson(json);
    }
    return null;
  }
}

class RemoteServiceChiTietPhieu {
  Future<ChiTietPhieu?> getPhieu() async {
    var uri = Uri.parse('https://atvs.vnptsonla.com/api/phieu/$idphieu');
    var respond = await client.get(uri);
    if (respond.statusCode == 200) {
      var json = respond.body;
      return chiTietPhieuFromJson(json);
    }
    return null;
  }
}
