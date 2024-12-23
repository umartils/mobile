import 'package:meta/meta.dart';
import 'dart:convert';

AbsenModel absenModelFromJson(String str) =>
    AbsenModel.fromJson(json.decode(str));

String absenModelToJson(AbsenModel data) => json.encode(data.toJson());

class AbsenModel {
  AbsenModel({required this.tanggal, required this.jam, required this.status});
  late String tanggal;
  late String jam;
  late String status;

  AbsenModel.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    jam = json['jam'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal'] = this.tanggal;
    data['jam'] = this.jam;
    data['status'] = this.status;
    return data;
  }
}
