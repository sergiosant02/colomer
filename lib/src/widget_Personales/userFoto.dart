import 'package:colomer_dental/src/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';

class UserFoto {
  Widget userFotoHead(BuildContext context, UserModel _userModel) {
    final size = MediaQuery.of(context).size;
    final pila = Stack(
      children: [
        Container(
          color: Colors.blue[800],
          height: size.height * 0.4,
          width: size.width,
        ),
        Positioned(
          top: size.height * 0.03,
          left: size.width * 0.25,
          child: Column(children: [
            Container(
              width: size.width * 0.5,
              height: size.width * 0.5,
              margin: EdgeInsets.only(bottom: 20),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: pref.log
                  ? _obtenerFoto(_userModel, size)
                  : Icon(
                      Icons.person,
                      size: size.width * 0.4,
                      color: Colors.blue[800],
                    ),
            ),
            pref.log
                ? Text(
                    _userModel.nombre,
                    style: GoogleFonts.bitter(fontSize: size.width * 0.05),
                  )
                : Container(),
          ]),
        )
      ],
    );
    return pila;
  }

  Widget _obtenerFoto(UserModel _userModel, Size size) {
    switch (_userModel.fotoStatus) {
      case true:
        return ClipRRect(
          borderRadius: BorderRadius.circular(360),
          child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/loading/progress_icon.gif'),
              image: NetworkImage(_userModel.foto)),
        );
        break;
      case false:
        return Icon(
          Icons.person,
          size: size.width * 0.4,
          color: Colors.blue[800],
        );
        break;
      default:
        return Icon(
          Icons.person,
          size: size.width * 0.4,
          color: Colors.blue[800],
        );
        break;
    }
  }
}
