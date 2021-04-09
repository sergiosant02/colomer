import 'package:flutter/material.dart';

class FondoNews {
  Widget fondo(BuildContext context, Color color) {
    return Container(
      height: MediaQuery.of(context).size.width * 1.6,
      width: MediaQuery.of(context).size.width * 1.5,
      decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(color: Colors.blue[100], blurRadius: 45, spreadRadius: 5),
          ],
          shape: BoxShape.circle),
    );
  }
}
