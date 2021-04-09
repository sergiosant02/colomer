import 'package:colomer_dental/main.dart';
import 'package:colomer_dental/src/Utils/utils.dart';
import 'package:colomer_dental/src/models/clinicasModel.dart';
import 'package:colomer_dental/src/providers/providerPage.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CitasPage extends StatefulWidget {
  CitasPage({Key key}) : super(key: key);

  @override
  _CitasPageState createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> {
  int _clinicaSelect = 0;
  final Utils utils = Utils();
  @override
  Widget build(BuildContext context) {
    final _dateProvider = Provider.of<ProviderPage>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_dateProvider.date != null && _clinicaSelect != 0) {
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Faltan datos'),
                    content:
                        Text('Debe introducir la fecha deseada y la clínica'),
                    actions: [
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Aceptar'))
                    ],
                  );
                });
          }
        },
        label: Text(
          'Consultar disponibilidad',
          maxLines: 1,
        ),
        shape: StadiumBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Reserva de citas'),
        backgroundColor: Colors.blue[600],
      ),
      body: SafeArea(child: _primerCalendar(context)),
    );
  }

  Widget _calendarioPropio(BuildContext context) {
    final _dateProvider = Provider.of<ProviderPage>(context);
    final size = MediaQuery.of(context).size;
    final container = Container(
        child: utils.construirCalendario(
            context, _dateProvider.date.year, _dateProvider.date.month),
        height: size.width + size.width / 7);
    return Column(
      children: [
        container,
      ],
    );
  }

  Widget _primerCalendar(BuildContext context) {
    final _dateProvider = Provider.of<ProviderPage>(context);
    final size = MediaQuery.of(context).size;
    List<String> _clinicasName = [];
    List clinicas2 = [Clinicas(nombre: 'Seleccione una clínica')] + clinicas;
    for (Clinicas i in clinicas2) {
      _clinicasName.add(i.nombre);
    }

    List<Widget> _buildItems1() {
      return _clinicasName
          .map((val) => MySelectionItem(
                title: val,
              ))
          .toList();
    }

    final _fecha = Row(
      children: [
        RaisedButton(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.025),
              child: Text(
                'Seleccionar fecha',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            color: Colors.blue[600],
            shape: StadiumBorder(),
            onPressed: () async => _dateProvider.date = await showDatePicker(
                //locale: Locale('es', 'ES'),
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
                cancelText: 'Cancelar',
                confirmText: 'Aceptar',
                helpText: 'Seleccione una fecha')),
        Spacer(),
        Text(
          _dateProvider.date != null
              ? '${_dateProvider.date.day} / ${_dateProvider.date.month} / ${_dateProvider.date.year}'
              : 'Fecha no seleccionada',
          style: TextStyle(fontSize: size.width * 0.035),
        )
      ],
    );
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _fecha,
            SizedBox(
              height: 20,
            ),
            DirectSelect(
                itemExtent: 35.0,
                selectedIndex: _clinicaSelect,
                child: MySelectionItem(
                  isForList: false,
                  title: _clinicasName[_clinicaSelect],
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _clinicaSelect = index;
                    print(_clinicasName[_clinicaSelect]);
                  });
                },
                items: _buildItems1()),
            Text(
              'Mantén presionado para la selección',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: FittedBox(
          child: Text(
        title,
      )),
    );
  }
}
