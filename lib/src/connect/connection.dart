import 'dart:convert';
import 'dart:io';
import 'package:colomer_dental/src/models/clinicasModel.dart';
import 'package:colomer_dental/src/models/noticiasModel.dart';
import 'package:colomer_dental/src/models/userModel.dart';
import 'package:http/http.dart' as http;

class UsuariosProvider {
  final String _urlRed = 'concoapps.000webhostapp.com';

  Future<List<UserModel>> obtenerUsuarios() async {
    List<UserModel> listaUsuario = [];
    final _url = 'http://$_urlRed/getUsuarios.php';
    final resp = await http.get(_url);
    final decode = json.decode(resp.body);
    for (var i in decode) {
      listaUsuario.add(UserModel.fromJson(i));
    }
    return listaUsuario;
  }

  Future<bool> comprobarRepUser(String correo) async {
    List<UserModel> listaUsuario = [];
    final _url = 'http://$_urlRed/getUsuarios.php';
    final resp = await http.get(_url);
    final decode = json.decode(resp.body);
    for (var i in decode) {
      listaUsuario.add(UserModel.fromJson(i));
    }
    bool _existe = false;
    for (var i in listaUsuario) {
      if (i.correo == correo) {
        _existe = true;
      }
    }
    return _existe;
  }

  Future<void> crearUser(UserModel _user) async {
    final _url = 'http://$_urlRed/addUser.php';
    try {
      print('proceso');
      await http.post(_url, body: _user.toJson());
    } catch (e) {
      print(e);
    }
  }
}

class PublicacionesProvider {
  final String _urlRed = 'concoapps.000webhostapp.com';

  Future<List<NoticiasModel>> obtenerNoticias() async {
    List<NoticiasModel> noticiasLista = [];
    final _url = 'http://$_urlRed/getPublicaciones.php';
    final res = await http.get(_url);
    final decode = json.decode(res.body);
    for (var i in decode) {
      noticiasLista.add(NoticiasModel.fromJson(i));
    }
    return noticiasLista;
  }

  Future<String> subirFotoMySQL(File file) async {
    final url = "http://$_urlRed/addFoto.php";
    final base64Image = base64Encode(file.readAsBytesSync());
    final fileName = file.path.split('/').last;
    await http.post(url, body: {
      "nameImage": fileName,
      "image": base64Image,
    });
    //print(resp.body);
    return fileName;
  }

  Future<void> addNew(NoticiasModel _noticia) async {
    final _url = 'http://$_urlRed/addNew.php';
    try {
      print('proceso carga noticia');
      print(_noticia.titulo);
      print(_noticia.contenido);
      print(_noticia.fotoStatus);
      print(_noticia.fotoUrl);
      print(_noticia.fecha);
      await http.post(_url, body: {
        'titulo': _noticia.titulo,
        'contenido': _noticia.contenido,
        'fotoStatus': _noticia.fotoStatus ? '1' : '0',
        'fotoUrl': _noticia.fotoUrl,
        'fecha': _noticia.fecha
      });
    } catch (e) {
      print('error!!!');
      print(e);
    }
  }

  Future<void> deleteNew(NoticiasModel _noticia) async {
    final _url = 'http://$_urlRed/borrarNew.php';
    try {
      await http.post(_url, body: {'id': _noticia.id});
    } catch (e) {
      print('error!!!');
      print(e);
    }
  }

  Future<void> deleteFoto(NoticiasModel _noticia) async {
    final _url = 'http://$_urlRed/eliminarFoto.php';
    try {
      await http.post(_url, body: {'nameImage': _noticia.fotoUrl});
    } catch (e) {
      print('error!!!');
      print(e);
    }
  }
}

class ClinicasProvider {
  final String _urlRed = 'concoapps.000webhostapp.com';

  Future<List<Clinicas>> getClinicas() async {
    List<Clinicas> clinicasLista = [];
    final _url = 'http://$_urlRed/getClinicas.php';
    final res = await http.get(_url);
    final decode = json.decode(res.body);
    for (var i in decode) {
      clinicasLista.add(Clinicas.fromJson(i));
      print(Clinicas.fromJson(i).direccion);
    }
    return clinicasLista;
  }
}
