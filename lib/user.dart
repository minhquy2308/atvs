import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.msg,
    required this.userInfo,
  });

  String msg;
  UserInfo userInfo;

  factory User.fromJson(Map<String, dynamic> json) => User(
    msg: json["msg"],
    userInfo: UserInfo.fromJson(json["user_info"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "user_info": userInfo.toJson(),
  };
}

class UserInfo {
  UserInfo({
    required this.userId,
    required this.donviId,
    required this.roleId,
    required this.username,
    required this.tenDonvi,
    required this.fullname,
  });

  int userId;
  int donviId;
  String roleId;
  String username;
  String tenDonvi;
  String fullname;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    userId: json["user_id"],
    donviId: json["donvi_id"],
    roleId: json["role_id"],
    username: json["username"],
    tenDonvi: json["ten_donvi"],
    fullname: json["fullname"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "donvi_id": donviId,
    "role_id": roleId,
    "username": username,
    "ten_donvi": tenDonvi,
    "fullname": fullname,
  };
}
