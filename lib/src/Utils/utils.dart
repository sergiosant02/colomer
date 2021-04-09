import 'dart:math';

import 'package:flutter/material.dart';

class Utils {
  Widget _diasdesign(int a, int b, List semana, double tam) {
    return Container(
      child: semana[a][b][0] == 0
          ? Text(' ')
          : Center(
              child: Text(
                semana[a][b][1].toString(),
                textAlign: TextAlign.center,
              ),
            ),
      height: tam,
      width: tam,
      color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), 1),
    );
  }

  List<Widget> _encabezadoCalendar(double tam) {
    List<Widget> _dias = [];
    List<String> _nDias = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
    for (var i in _nDias) {
      _dias.add(Center(
          child: Container(
        alignment: Alignment.center,
        color: Colors.blue[600],
        height: tam,
        width: tam,
        child: Text(
          i,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      )));
    }
    return _dias;
  }

  int obtenerNumeroDeDiasDeMes(int year, int month) {
    if (month == 2) {
      if (year % 4 == 0) {
        return 29;
      } else {
        return 28;
      }
    } else if (month % 2 == 0 && month < 8) {
      return 30;
    } else if (month % 2 != 0 && month > 8) {
      return 30;
    } else if (month == 8) {
      return 31;
    } else {
      return 31;
    }
  }

  List obtenerDiaDeLaSemana(DateTime date) {
    Map<int, String> semana = {
      1: 'Lunes',
      2: 'Martes',
      3: 'Miercoles',
      4: 'Jueves',
      5: 'Viernes',
      6: 'Sábado',
      7: 'Domingo'
    };
    return [date.weekday, semana[date.weekday]];
  }

  List<List> rellenarCalendar(int year, int month) {
    List<List> semana = [[], [], [], [], [], [], []];
    bool cond = false;
    for (int i = 1; i <= obtenerNumeroDeDiasDeMes(year, month); i++) {
      for (int j = 1; j <= 7; j++) {
        if (DateTime(year, month, i).weekday == j) {
          cond = true;
          semana[j - 1].add([1, DateTime(year, month, i).day]);
        } else if (DateTime(year, month, i).weekday != j && cond == false) {
          print('dia de la semana: ' +
              DateTime(year, month, i).weekday.toString());
          semana[j - 1].add([0, 0]);
        } else {
          print('posible error ${DateTime(year, month, i).weekday}');
        }
      }
    }
    print(semana);
    return semana;
  }

  Widget construirCalendario(BuildContext context, int year, int month) {
    final size = MediaQuery.of(context).size;
    List<List> semana = rellenarCalendar(year, month);
    final tam = size.width / 7;

    List<Widget> dias1 = List.generate(semana[0].length, (int i) {
      return _diasdesign(0, i, semana, tam);
    });
    List<Widget> dias2 = List.generate(semana[1].length, (int i) {
      return _diasdesign(1, i, semana, tam);
    });
    List<Widget> dias3 = List.generate(semana[2].length, (int i) {
      return _diasdesign(2, i, semana, tam);
    });
    List<Widget> dias4 = List.generate(semana[3].length, (int i) {
      return _diasdesign(3, i, semana, tam);
    });
    List<Widget> dias5 = List.generate(semana[4].length, (int i) {
      return _diasdesign(4, i, semana, tam);
    });
    List<Widget> dias6 = List.generate(semana[5].length, (int i) {
      return _diasdesign(5, i, semana, tam);
    });
    List<Widget> dias7 = List.generate(semana[6].length, (int i) {
      return _diasdesign(6, i, semana, tam);
    });

    return Column(children: [
      Row(
        children: _encabezadoCalendar(tam),
      ),
      Container(
        height: size.width,
        width: size.width,
        child: Row(
          children: [
            Column(children: dias1),
            Column(children: dias2),
            Column(children: dias3),
            Column(children: dias4),
            Column(children: dias5),
            Column(children: dias6),
            Column(children: dias7),
          ],
        ),
      ),
    ]);
  }
}
