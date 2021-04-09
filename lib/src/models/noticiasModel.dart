// To parse this JSON data, do
//
//     final noticiasModel = noticiasModelFromJson(jsonString);

import 'dart:convert';

NoticiasModel noticiasModelFromJson(String str) =>
    NoticiasModel.fromJson(json.decode(str));

String noticiasModelToJson(NoticiasModel data) => json.encode(data.toJson());

class NoticiasModel {
  NoticiasModel({
    this.titulo,
    this.id,
    this.contenido,
    this.fotoStatus,
    this.fotoUrl = '',
    this.fecha,
  });

  String id;
  String titulo = '';
  String contenido = '';
  bool fotoStatus = false;
  String fotoUrl = '';
  String fecha = '';

  factory NoticiasModel.fromJson(Map<String, dynamic> json) => NoticiasModel(
        id: json["id"],
        titulo: json["titulo"],
        contenido: json["contenido"],
        fotoStatus: json["fotoStatus"] == '1' ? true : false,
        fotoUrl: (json["fotoUrl"]),
        fecha: json["fecha"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "contenido": contenido,
        "fotoStatus": fotoStatus == true ? '1' : '0',
        "fotoUrl": fotoUrl,
        "fecha": fecha,
      };
}
