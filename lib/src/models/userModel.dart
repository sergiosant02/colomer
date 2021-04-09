// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.nombre = '',
    this.correo = '',
    this.password = '',
    this.dni = '',
    this.nacimiento = '',
    this.fotoStatus = false,
    this.foto = '',
  });

  String nombre;
  String correo;
  String password;
  String dni;
  String nacimiento;
  bool fotoStatus;
  String foto;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nombre: json["nombre"],
        correo: json["correo"],
        password: json["password"],
        dni: json["dni"],
        nacimiento: json["nacimiento"],
        fotoStatus: json["fotoStatus"] == "0" ? false : true,
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "correo": correo,
        "password": password,
        "dni": dni,
        "nacimiento": nacimiento,
        "fotoStatus": fotoStatus == true ? '1' : '0',
        "foto": foto,
      };
}
