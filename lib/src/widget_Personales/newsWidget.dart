import 'package:colomer_dental/src/models/noticiasModel.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class NewsAppear {
  Widget newsBox(BuildContext context, NoticiasModel _noticiasModel) {
    if (_noticiasModel.fotoStatus) {
      print(_noticiasModel.titulo);
      print(_noticiasModel.fotoUrl);
    }
    final size = MediaQuery.of(context).size;
    final radioCurvatura = 7.0;
    final tarjeta = Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radioCurvatura),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 3, blurRadius: 10)
          ]),
      width: size.width * 0.85,
      child: Column(children: [
        Container(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Text(
              _noticiasModel.titulo,
              style: GoogleFonts.fjallaOne(fontSize: size.width * 0.07),
              maxLines: 3,
            ),
            Text(
              _noticiasModel.contenido,
              style: GoogleFonts.caveat(
                  fontSize: size.width * 0.06, color: Colors.black54),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
        if (_noticiasModel.fotoStatus) ...[
          SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radioCurvatura),
                bottomRight: Radius.circular(radioCurvatura)),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading/points.gif'),
              image: NetworkImage('http://concoapps.000webhostapp.com/' +
                  _noticiasModel.fotoUrl),
              width: double.infinity,
              height: size.height * 0.25,
              fit: BoxFit.cover,
            ),
          )
        ]
      ]),
    );
    return tarjeta;
  }
}
