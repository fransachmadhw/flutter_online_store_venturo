// To parse this JSON data, do
//
//     final vouchers = vouchersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Vouchers vouchersFromJson(String str) => Vouchers.fromJson(json.decode(str));

String vouchersToJson(Vouchers data) => json.encode(data.toJson());

class Vouchers {
  final int statusCode;
  final List<Data> datas;

  Vouchers({
    required this.statusCode,
    required this.datas,
  });

  factory Vouchers.fromJson(Map<String, dynamic> json) => Vouchers(
        statusCode: json["status_code"],
        datas: List<Data>.from(json["datas"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
      };
}

class Data {
  final int id;
  final String kode;
  final int nominal;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.kode,
    required this.nominal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        kode: json["kode"],
        nominal: json["nominal"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nominal": nominal,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
