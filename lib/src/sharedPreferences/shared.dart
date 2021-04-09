import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _singleton = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _singleton;
  }
  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get log {
    return _prefs.getBool('log') ?? false;
  }

  set log(bool log) {
    _prefs.setBool('log', log);
  }

  get pagePral {
    return _prefs.getString('pagePral') ?? "/bottom";
  }

  set pagePral(String page) {
    _prefs.setString('pagePral', page);
  }

  get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String nombre) {
    _prefs.setString('nombre', nombre);
  }

  get correo {
    return _prefs.getString('correo') ?? '';
  }

  set correo(String correo) {
    _prefs.setString('correo', correo);
  }

  get password {
    return _prefs.getString('correo') ?? '';
  }

  set password(String password) {
    _prefs.setString('password', password);
  }

  get fotoStatus {
    return _prefs.getString('correo') ?? false;
  }

  set fotoStatus(bool fotoStatus) {
    _prefs.setBool('fotoStatus', fotoStatus);
  }

  get foto {
    return _prefs.getString('correo') ?? '';
  }

  set foto(String foto) {
    _prefs.setString('foto', foto);
  }

  get nacimiento {
    return _prefs.getString('nacimiento') ?? '';
  }

  set nacimiento(String nacimiento) {
    _prefs.setString('nacimiento', nacimiento);
  }

  get dni {
    return _prefs.getString('dni') ?? '';
  }

  set dni(String dni) {
    _prefs.setString('dni', dni);
  }
}
