import 'package:colomer_dental/main.dart';
import 'package:colomer_dental/src/connect/connection.dart';
import 'package:colomer_dental/src/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  UserModel _usuario = UserModel();
  bool _ocultar = true;
  bool _registro = true;
  final conect = UsuariosProvider();
  Map<int, String> dniCorrespondencia = {
    0: 'T',
    1: 'R',
    2: 'W',
    3: 'A',
    4: 'G',
    5: 'M',
    6: 'Y',
    7: 'F',
    8: 'P',
    9: 'D',
    10: 'X',
    11: 'B',
    12: 'N',
    13: 'J',
    14: 'Z',
    15: 'S',
    16: 'Q',
    17: 'V',
    18: 'H',
    19: 'L',
    20: 'C',
    21: 'K',
    22: 'E'
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                Container(
                  height: size.height * 0.4,
                  color: Colors.blue[700],
                ),
                Container(
                  width: size.width,
                  child: Text(
                    "Colomer dental",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.permanentMarker(
                        fontSize: size.width * 0.1, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: size.width * 0.2,
                  left: size.width * 0.25,
                  child: Icon(
                    Icons.account_circle,
                    size: size.width * 0.5,
                    color: Colors.white,
                  ),
                ),
              ]),
              SizedBox(
                height: size.height * 0.08,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      hintText: 'Escriba su correo'),
                  onChanged: (value) {
                    _usuario.correo = value.toLowerCase();
                  },
                  validator: (value) {
                    return validateEmail(value);
                  },
                ),
              ),
              if (!_registro) ...[
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Nombre y apellidos',
                        border: OutlineInputBorder(),
                        hintText: 'Escriba su nombre y apellidos'),
                    onChanged: (value) {
                      _usuario.nombre = value;
                    },
                    validator: (value) {
                      if (value.split(' ').length < 2) {
                        return 'Debe escribir al menos un apellido';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'DNI',
                        border: OutlineInputBorder(),
                        hintText: 'Escriba su DNI'),
                    onChanged: (value) {
                      _usuario.dni = value;
                    },
                    validator: (value) {
                      return validarDNI(value);
                    },
                  ),
                ),
              ],
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  obscureText: _ocultar,
                  decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                      hintText: 'Escriba su correo'),
                  onChanged: (value) {
                    _usuario.password = value;
                  },
                  validator: (value) {
                    if (value.length < 8) {
                      return 'Escriba más de 8 caracteres';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SwitchListTile(
                  title: Text('Mostar contraseña'),
                  value: !_ocultar,
                  onChanged: (value) {
                    setState(() {
                      _ocultar = !_ocultar;
                    });
                  }),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                  color: Colors.blue[700],
                  shape: StadiumBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Iniciar sesión',
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) return null;
                    switch (_registro) {
                      case false:
                        registroProcess(context);
                        break;
                      case true:
                        loginProcess(context, _usuario);
                        break;
                      default:
                        loginProcess(context, _usuario);
                        break;
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: _registro
                    ? Text(
                        'Quiero registrarme',
                        style: TextStyle(color: Colors.blue[900]),
                      )
                    : Text(
                        'Quiero iniciar sesión',
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                onTap: () {
                  _registro = !_registro;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                color: Colors.blue[300],
                shape: StadiumBorder(),
                onPressed: () => Navigator.pushNamed(context, '/bottom'),
                child: Text(
                  'Acceder como invitado',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value == 'familiacolomer@colomer.com') {
      return null;
    }
    if (!regex.hasMatch(value))
      return 'Introduce un email válido';
    else
      return null;
  }

  String validarDNI(String dni) {
    int numero = int.tryParse(dni.substring(0, 8));
    String letra = dni[8];
    int res = numero % 23;
    if (dniCorrespondencia[res] == letra.toUpperCase()) {
      return null;
    } else {
      return 'Debe escribir un DNI válido';
    }
  }

  loginProcess(BuildContext context, UserModel _usuarioModelProcess) async {
    List<UserModel> usuarios = await conect.obtenerUsuarios();
    bool _bandera = false;
    for (var i in usuarios) {
      if (i.correo == _usuarioModelProcess.correo &&
          i.password == _usuarioModelProcess.password) {
        showDialog(
          context: context,
          builder: (context) => Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
        );
        _bandera = true;
        pref.pagePral = '/bottom';
        _guardarDatos(i);
        print(pref.correo);
        Navigator.pushReplacementNamed(context, '/bottom');
        break;
      } else if (i.correo == _usuarioModelProcess.correo &&
          i.password != _usuarioModelProcess.password) {
        _bandera = true;
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Contraseña incorrecta.'),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Aceptar'))
                ],
              );
            });
        break;
      }
    }
    if (_bandera == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
              'No existe ninguna cuenta que coincida con el correo introducido.'),
          actions: [
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text('Aceptar'))
          ],
        ),
      );
    }
  }

  registroProcess(BuildContext context) async {
    if (await conect.comprobarRepUser(_usuario.correo)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Ya existe este correo.'),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Entendido'))
              ],
            );
          });
    } else {
      final picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        //confirmText: 'Aceptar',
      );
      _usuario.nacimiento = "${picker.day}/${picker.month}/${picker.year}";
      if (_usuario.nacimiento != null) {
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              );
            });
        conect.crearUser(_usuario);
        pref.pagePral = '/bottom';
        _guardarDatos(_usuario);
        Navigator.pushReplacementNamed(context, '/bottom');
      }
    }
  }

  void _guardarDatos(UserModel _userModelGuardar) {
    pref.log = true;
    pref.correo = _userModelGuardar.correo;
    pref.dni = _userModelGuardar.dni;
    pref.foto = _userModelGuardar.foto;
    pref.fotoStatus = _userModelGuardar.fotoStatus;
    pref.nacimiento = _userModelGuardar.nacimiento;
    pref.nombre = _userModelGuardar.nombre;
    pref.password = _userModelGuardar.password;
  }
}
