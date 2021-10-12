// To parse this JSON data, do
//
//     final scanModel = scanModelFromMap(jsonString);

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromMap(String str) => ScanModel.fromMap(json.decode(str));

String scanModelToMap(ScanModel data) => json.encode(data.toMap());

class ScanModel {
  ScanModel({
    this.id,
    this.tipo,
    required this.valor,
  }) {
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  int? id;
  String? tipo;
  String valor;

  LatLng getLatLng() {
    final latlng = valor.substring(4).split(',');
    final lat = double.parse(latlng.elementAt(0));
    final lng = double.parse(latlng.elementAt(1));
    return LatLng(lat, lng);
  }

  factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
