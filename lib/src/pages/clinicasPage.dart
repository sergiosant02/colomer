import 'package:animate_do/animate_do.dart';
import 'package:colomer_dental/main.dart';
import 'package:colomer_dental/src/widget_Personales/tarjetasClinicas.dart';
import 'package:flutter/material.dart';

class ClinicasPage extends StatefulWidget {
  ClinicasPage({Key key}) : super(key: key);

  @override
  _ClinicasPageState createState() => _ClinicasPageState();
}

class _ClinicasPageState extends State<ClinicasPage> {
  @override
  Widget build(BuildContext context) {
    TarjetasClinicas _tarjetas = TarjetasClinicas();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[600],
        title: Text('Información sobre clínicas'),
      ),
      body: ListView.builder(
          itemCount: clinicas.length,
          itemBuilder: (context, i) {
            return ZoomIn(
                duration: Duration(milliseconds: 500 * (i + 1)),
                child: _tarjetas.tarjetasClinicas(clinicas[i]));
          }),
    );
  }
}
