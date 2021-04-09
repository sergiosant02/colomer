import 'package:colomer_dental/src/models/userModel.dart';
import 'package:colomer_dental/src/widget_Personales/userFoto.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = UserFoto();
    final usermod = UserModel();
    usermod.correo = pref.correo;
    usermod.nombre = pref.nombre;
    usermod.dni = pref.dni;
    usermod.foto = pref.foto;
    usermod.fotoStatus = false;
    usermod.nacimiento = pref.nacimiento;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.blue[800],
      ),
      body: ListView(physics: BouncingScrollPhysics(), children: [
        user.userFotoHead(context, usermod),
        if (pref.log) ...[
          ListTile(
            title: Text('Información personal'),
            onTap: () {
              Navigator.of(context).pushNamed('/datos');
            },
          ),
          Divider(),
          ListTile(
            title: Text('Citas'),
          ),
          Divider(),
          SizedBox(
            height: size.height * 0.1,
          ),
        ],
        !pref.log ? SizedBox(height: size.height * 0.2) : Container(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: RaisedButton(
            onPressed: () {
              if (pref.log) {
                _salirUsuario();
              }
              Navigator.pushNamed(context, '/login');
            },
            color: Colors.blue[800],
            shape: StadiumBorder(),
            child: pref.log
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Cerrar sesión',
                      style: GoogleFonts.galada(
                          fontSize: size.width * 0.05, color: Colors.white),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Iniciar sesión',
                      style: GoogleFonts.galada(
                          fontSize: size.width * 0.05, color: Colors.white),
                    ),
                  ),
          ),
        )
      ]),
    );
  }

  void _salirUsuario() {
    pref.log = false;
    pref.correo = '';
    pref.dni = '';
    pref.foto = '';
    pref.fotoStatus = false;
    pref.nacimiento = '';
    pref.nombre = '';
    pref.password = '';
  }
}
