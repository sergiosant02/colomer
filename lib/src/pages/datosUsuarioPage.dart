import 'package:flutter/material.dart';

import '../../main.dart';

class DatosUsuarioPage extends StatefulWidget {
  DatosUsuarioPage({Key key}) : super(key: key);

  @override
  _DatosUsuarioPageState createState() => _DatosUsuarioPageState();
}

class _DatosUsuarioPageState extends State<DatosUsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text('Información personal'),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _estructuraDato2(context, 'Nombre', pref.nombre),
          _estructuraDato2(context, 'Correo electrónico', pref.correo),
          _estructuraDato2(context, 'DNI', pref.dni),
          _estructuraDato2(context, 'Fecha de nacimiento', pref.nacimiento)
        ],
      )),
    );
  }

  Widget _estructuraDato(BuildContext context, String titulo, String dato) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            dato,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _estructuraDato2(BuildContext context, String titulo, String dato) {
    return ListTile(
      title: Text(titulo),
      subtitle: Text(dato),
    );
  }
}
